<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Droithistos;
use App\Models\Ecohistos;
use App\Models\Ecolages;
use App\Models\Etudiants;
use App\Models\Moisecolage;
use App\Models\Sousetudiants;
use App\Models\Studentdroits;
use Illuminate\Http\Request;

class EcolageController extends Controller
{
    //INCREMENTATION DU SOLDE PAR RAPPORT A MONTANT QUI CORRESPOND AU NIVEAU DU NOUVEAU ETUDIANT

    public function increment($ac_id, $ecolage){

        if(Ecolages::where('ac_id', $ac_id)->exists()){
            $last_solde = Ecolages::where('ac_id', $ac_id)->first()->solde;
            Ecolages::where('ac_id', $ac_id)->update([
                'solde' => $last_solde + $ecolage
            ]);
        }else{
            Ecolages::create([
                'ac_id' => $ac_id,
                'solde' => $ecolage
            ]);
        }
    }

    public function decrement($ac_id, $ecolage){
        if(Ecolages::where('ac_id', $ac_id)->exists()){
            $last_solde = Ecolages::where('ac_id', $ac_id)->first()->solde;
            Ecolages::where('ac_id', $ac_id)->update([
                'solde' => $last_solde - $ecolage
            ]);
        }
    }

    //PAIEMENT ECOLAGE
    public function pay($id,Request $request,DepensesMoisController $depensemois, RevenusMoisController $revenusmois, AuditsController $audit){
        $fields = $request->validate([
            'cost' => 'required',
            'type' => 'required',
        ]);

        $montant = $fields['cost'];
        $type = $fields['type'];

        if ($montant == 0){
            throw new \Error('Le montant ne doit pas etre null');
        }

        $moisecolage = Moisecolage::findOrFail($id);
        $classe = Sousetudiants::where('id', $moisecolage->et_id)->with('classe')->first()['classe'];
        $prof = Sousetudiants::where('id', $moisecolage->et_id)->with('student')->first()['student']->enfantProf == 1;
        if($type == 'complet'){
            if($moisecolage->reste != ($prof ? $classe->ecolage / 2: $classe->ecolage)){
                throw new \Error('Une avance a deja été payé');
            }else{
                $moisecolage->update(['payé' => 1, 'reste' => 0, 'paid' => ($prof ? $classe->ecolage / 2: $classe->ecolage)]);
                $this->increment($request->ac_id,$moisecolage->reste);
                $revenusmois->increment($request->ac_id, date('y-m-d'),($prof ? $classe->ecolage / 2: $classe->ecolage));
                $message = "payement  ecolage";
                Ecohistos::create(['montant' => ($prof ? $classe->ecolage / 2: $classe->ecolage), 'ec_id' => $id, 'type' => $type, 'reste' => 0]);

                $audit->listen('Financier', $message, $request->user()->id);
                return response()->json(['message' => 'Ecolage payé']);
            }
        }elseif($type == 'avance'){
            if ($montant > $moisecolage->reste){
                throw new \Error("le montant ne doit pas depasser le reste à payer {$moisecolage->reste}");
            }else{
                if($montant == $moisecolage->reste){
                    $paye = 1;
                }else{
                    $paye = 0;
                }
                $moisecolage->update(['payé' => $paye, 'reste' => $moisecolage->reste - $montant, 'paid' => $moisecolage->paid + $montant]);
                $this->increment($request->ac_id, $montant);
                $revenusmois->increment($request->ac_id, date('y-m-d'),$montant);
                $message = "payement avance ecolage";
                $audit->listen('Financier', $message, $request->user()->id);
                Ecohistos::create(['montant' => $montant, 'ec_id' => $id, 'type' => $type, 'reste' => $moisecolage->reste]);
                return response()->json(['message' => 'Avance ecolage payé']);

            }
        }else{
            if($moisecolage->paid == 0){
                throw new \Error('Impossible de rembourser, aucune somme n\'a été payé');

            }else{
                $this->decrement($request->ac_id,$moisecolage->paid);
                Ecohistos::create(['montant' => $moisecolage->paid, 'ec_id' => $id, 'type' => 'rembourse', 'reste' => $prof?$classe->ecolage / 2: $classe->ecolage]);
                $depensemois->increment($request->ac_id, date('y-m-d'),$moisecolage->paid);
                $moisecolage->update(['payé' => 0, 'reste' => $prof?$classe->ecolage / 2: $classe->ecolage, 'paid' => 0]);
                $message = "Remboursement ecolage";
                $audit->listen('Financier', $message, $request->user()->id);
//                Ecohistos::create(['montant' => $montant, 'ec_id' => $id, 'type' => $type, 'reste' => $prof?$classe->ecolage / 2: $classe->ecolage]);
                return response()->json(['message' => 'ecolage remboursé']);
            }
        }

    }


    //SOMME TOTAL DE TOUS LES ECOLAGES EXISTANTS
    public function total(){
        $ac_id = Acs::latest()->first()->id;
        $ecolages = Ecolages::where('ac_id', $ac_id)->first()->solde;



        return response()->json(['title' => "Solde d'écolages", 'value' => $ecolages, 'icon' => 'FaMoneyBillWave']);
    }


    public function ecoinfo($id){
        return Moisecolage::where('id', $id)->first(['payé']);
    }

    public function delecohisto($id){

    }

}
