<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Droithistos;
use App\Models\Droits;
use App\Models\Sousetudiants;
use App\Models\Studentdroits;
use Illuminate\Http\Request;

class DroitsController extends Controller
{
    //INCREMENTATION DU SOLDE PAR RAPPORT A MONTANT QUI CORRESPOND AU NIVEAU DU NOUVEAU ETUDIANT

    public function increment($ac_id, $ecolage){

        if(Droits::where('ac_id', $ac_id)->exists()){
            $last_solde = Droits::where('ac_id', $ac_id)->first()->solde;
            Droits::where('ac_id', $ac_id)->update([
                'solde' => $last_solde + $ecolage
            ]);
        }else{
            Droits::create([
                'ac_id' => $ac_id,
                'solde' => $ecolage
            ]);
        }
    }

    //SOMME TOTAL DE TOUS LES DROITS EXISTANTS
    public function total(){
        $ac_id = Acs::latest()->first()->id;
        $droits = Droits::where('ac_id', $ac_id)->first()->solde;

        return response()->json(['title' => 'Solde de droits', 'value' => $droits, 'icon' => 'FaWallet']);
    }

    public function decrement($ac_id, $droit){
        if(Droits::where('ac_id', $ac_id)->exists()){
            $last_solde = Droits::where('ac_id', $ac_id)->first()->solde;
            Droits::where('ac_id', $ac_id)->update([
                'solde' => $last_solde - $droit
            ]);
        }
    }

    public function pay($se_id, $montant, $type){
        $droit = Studentdroits::where('se_id', $se_id)->first();
        if(!$droit){
            throw new \Error('Impossible de payer le droit');
        }
        $mount = Sousetudiants::where('id', $se_id)->with('classe')->first()['classe']->droit;
        if(!$mount){
            throw new \Error('Impossible de payer le droit');
        }

        if($type == "complet"){
            if($droit->reste != $mount){
                throw new \Error('Impossible de payer en totalité, une avance a été payé');
            }

            Studentdroits::where('se_id', $se_id)->update(['reste' => $droit->reste - $mount, 'payed' => 1, 'paid' => $mount]);
            $this->increment(Acs::latest()->first()->id, $mount);
            Droithistos::create(['montant' => $mount, 'dr_id' => $droit->id, 'type' => $type, 'reste' => $droit->reste - $mount]);
            return response()->json(['message' => 'Paiement  effectué']);
        }elseif($type == "avance"){
            if($montant > $droit->reste){
                throw new \Error("Montant doit pas depasser le reste à payer({$droit->reste})");
            }else{
                if($montant == $droit->reste){
                    $payed = 1;
                }else{
                    $payed = 0;
                }
                Studentdroits::where('se_id', $se_id)->update(['reste' => $droit->reste - $montant, 'payed' => $payed, 'paid' => $droit->paid+$montant]);
                $this->increment(Acs::latest()->first()->id, $montant);
                Droithistos::create(['montant' => $montant, 'dr_id' => $droit->id, 'type' => $type, 'reste' => $droit->reste - $montant]);
                return response()->json(['message' => 'Paiement avance effectué']);
            }

        }else{
            if($droit->paid == 0){
                throw new \Error("Impossible de rembourser, aucune somme n'a été payé");
            }else{
                Studentdroits::where('se_id', $se_id)->update(['reste' => $mount, 'payed' => 0, 'paid' => 0]);
                $this->decrement(Acs::latest()->first()->id, $droit->paid);
                Droithistos::create(['montant' => $mount, 'dr_id' => $droit->id, 'type' => $type, 'reste' => $mount]);
                return response()->json(['message' => 'Remboursement effectué']);
            }
        }
    }
}
