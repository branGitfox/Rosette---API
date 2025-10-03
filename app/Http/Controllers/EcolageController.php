<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Ecolages;
use App\Models\Etudiants;
use App\Models\Moisecolage;
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
    public function pay($id,Request $request, RevenusMoisController $revenusmois){
        $montant = $request?->cost;
        Moisecolage::findOrFail($id)->update([
            'payé' => 1
        ]);
        $this->increment($request->ac_id,$request->prof==1?($montant/2):$montant);
        $revenusmois->increment($request->ac_id, Moisecolage::findOrFail($id)->mois,$request->prof==1?($montant/2):$montant);
        return response()->json(['message' => 'ecolage payé']);
    }


    //SOMME TOTAL DE TOUS LES ECOLAGES EXISTANTS
    public function total(){
        $ac_id = Acs::latest()->first()->id;
        $ecolages = Ecolages::where('ac_id', $ac_id)->first()->solde;



        return response()->json(['title' => "Solde d'écolages", 'value' => $ecolages, 'icon' => 'FaMoneyBillWave']);
    }

}
