<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Droithistos;
use App\Models\Kermessehistos;
use App\Models\Kermesses;
use App\Models\Sousetudiants;
use App\Models\Studentdroits;
use App\Models\Studentkermesses;
use Illuminate\Http\Request;

class KermessesController extends Controller
{
    //INCREMENTATION DU SOLDE PAR RAPPORT A MONTANT QUI CORRESPOND AU NIVEAU DU NOUVEAU ETUDIANT

    public function increment($ac_id, $ecolage){

        if(Kermesses::where('ac_id', $ac_id)->exists()){
            $last_solde = Kermesses::where('ac_id', $ac_id)->first()->solde;
            Kermesses::where('ac_id', $ac_id)->update([
                'solde' => $last_solde + $ecolage
            ]);
        }else{
            Kermesses::create([
                'ac_id' => $ac_id,
                'solde' => $ecolage
            ]);
        }
    }


    //SOMME TOTAL DE TOUS LES KERMESSES EXISTANTS
    public function total(){
        $ac_id = Acs::latest()->first()->id;
        $kermesses = Kermesses::where('ac_id', $ac_id)->first()->solde;


        return response()->json(['title' => 'Solde de kermesses', 'value' => $kermesses, 'icon' => 'FaCoins']);
    }

    public function decrement($ac_id, $kermesse){
        if(kermesses::where('ac_id', $ac_id)->exists()){
            $last_solde = kermesses::where('ac_id', $ac_id)->first()->solde;
            kermesses::where('ac_id', $ac_id)->update([
                'solde' => $last_solde - $kermesse
            ]);
        }
    }

    public function pay($se_id, $montant, $type){
        $kerm = Studentkermesses::where('se_id', $se_id)->first();
        $st = Sousetudiants::where('id', $se_id)->with('student')->first();
        $old = Sousetudiants::where('et_id', $st->student->id)->count() > 1;


        if(!$kerm){
            throw new \Error('Impossible de payer le droit');
        }
        $classe = Sousetudiants::where('id', $se_id)->with('classe')->first()['classe'];
        $mount =$old ? $classe->kermesse_ancien: $classe->kermesse;
        if(!$mount){
            throw new \Error('Impossible de payer le droit');
        }

        if($type == "complet"){
            if($kerm->reste != $mount){
                throw new \Error('Impossible de payer en totalité, une avance a été payé');
            }

            Studentkermesses::where('se_id', $se_id)->update(['reste' => $kerm->reste - $mount, 'payed' => 1, 'paid' => $mount]);
            $this->increment(Acs::latest()->first()->id, $mount);
            Kermessehistos::create(['montant' => $mount, 'kr_id' => $kerm->id, 'type' => $type, 'reste' => $kerm->reste - $mount]);
            return response()->json(['message' => 'Paiement  effectué']);
        }elseif($type == "avance"){
            if($montant > $kerm->reste){
                throw new \Error("Montant doit pas depasser le reste à payer({$kerm->reste})");
            }else{
                if($montant == $kerm->reste){
                    $payed = 1;
                }else{
                    $payed = 0;
                }
                Studentkermesses::where('se_id', $se_id)->update(['reste' => $kerm->reste - $montant, 'payed' => $payed, 'paid' => $kerm->paid+$montant]);
                $this->increment(Acs::latest()->first()->id, $montant);
                Kermessehistos::create(['montant' => $montant, 'kr_id' => $kerm->id, 'type' => $type, 'reste' => $kerm->reste - $montant]);
                return response()->json(['message' => 'Paiement avance effectué']);
            }

        }else{
            if($kerm->paid == 0){
                throw new \Error("Impossible de rembourser, aucune somme n'a été payé");
            }else{
                Studentkermesses::where('se_id', $se_id)->update(['reste' => $mount, 'payed' => 0, 'paid' => 0]);
                $this->decrement(Acs::latest()->first()->id, $kerm->paid);
                Kermessehistos::create(['montant' => $mount, 'kr_id' => $kerm->id, 'type' => $type, 'reste' => $mount]);
                return response()->json(['message' => 'Remboursement effectué']);
            }
        }
    }

    public function krinfo($id){
        return Studentkermesses::where('id', $id)->first(['payed']);
    }

}
