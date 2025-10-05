<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Droits;
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
}
