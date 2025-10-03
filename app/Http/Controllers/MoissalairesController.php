<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Archsals;
use App\Models\Ecolages;
use App\Models\Moissalaires;
use App\Models\Workers;
use Error;
use http\Env\Response;
use Illuminate\Http\Request;

class MoissalairesController extends Controller
{
    public function initializeMoissalaires($ac_id, $w_id, $mois, $payé, $salaire){
        Moissalaires::create([
            'ac_id' => $ac_id,
            'w_id' => $w_id,
            'mois' => $mois,
            'payé' => $payé,
            'reste' => $salaire
        ]);
    }

    public function moissalaires($id){
        $ac_id = Acs::latest()->first()->id;
        return response()->json(Moissalaires::where('ac_id', $ac_id)->where('w_id', $id)->get());
    }


    public function pay(Request $request, EcolageController $ecolages, ArchsalsController $archive, DepensesMoisController $depensemois){
        $fields = $request->validate([
            'montant' => 'required',
            'mois' => 'required',
            'type' => 'required',
//            'ac_id' => 'required',
            'w_id' => 'required',
            'motif' => 'nullable',
        ]);

        $ac_id = Acs::latest()->first()->id;
        if(Ecolages::where('ac_id', $ac_id)->first()->solde >= $fields['montant'] * count($fields['mois'])){

            if($fields['type'] == 1){
                if($fields['montant'] == Workers::where('id', $fields['w_id'])->first()->salaire_base ){

                        foreach ($fields['mois'] as $mois){
                            if( $fields['montant'] == Moissalaires::where('mois', $mois)->where('w_id', $fields['w_id'])->where('ac_id', $ac_id)->first()->reste){
                                Moissalaires::where('mois', $mois)->where('w_id', $fields['w_id'])->where('ac_id', $ac_id)->update([
                                    'payé' => true,
                                    'reste' => 0
                                ]);
                                $ecolages->decrement($ac_id, $fields['montant']);
                            }else{
                                throw new Error('Le salaire n\'est plus complet ('.Moissalaires::where('mois', $mois)->where('w_id', $fields['w_id'])->where('ac_id', $ac_id)->first()->reste.')');
                         }
                        }

                        $archive->save($fields['montant'], implode(',', $fields['mois']), 1, $ac_id, $fields['w_id'], $fields['motif']??' ');
                        $depensemois->increment($ac_id,date('y-m-d'), $fields['montant']*count($fields['mois']));
                        return response()->json(['message' => 'Paiment salaire effectué']);


                }else{
                    throw new Error('La somme doit etre identique au salaire base');
                }

            }else{

                foreach ($fields['mois'] as $mois){
                    $check = Moissalaires::where('mois', $mois)->where('w_id', $fields['w_id'])->where('ac_id', $ac_id)->first();
                    if($fields['montant'] > $check->reste){
                        throw new Error("Il reste {$check->reste} d'avance pour le mois de $mois");
                    }else{
                        if($fields['montant'] == $check->reste){
                            $check->update([
                                'reste' => 0,
                                'payé' => true
                            ]);
                            $ecolages->decrement($ac_id, $fields['montant']);
                        }else{
                            $check->update([
                                'reste' => $check->reste - $fields['montant'],
                            ]);
                            $ecolages->decrement($ac_id, $fields['montant']);

                        }
                    }

                }

                $archive->save($fields['montant'], implode(',', $fields['mois']), 0, $ac_id, $fields['w_id'], $fields['motif']??' ');
                $depensemois->increment($ac_id,date('y-m-d'), $fields['montant']*count($fields['mois']));
                return response()->json(['message' => 'Paiment avance effectué']);

            }
        }else{
            throw new Error('Solde d\'ecolage insuffisant');
        }

    }

    public function archives($id){
        $ac_id =request()->query('year')!='null'?request()->query('year'):Acs::latest()->first()->id;
        return \response()->json(Archsals::query()->where('w_id', $id)->where('ac_id',$ac_id )->orderByDesc('created_at')->get());
    }
}
