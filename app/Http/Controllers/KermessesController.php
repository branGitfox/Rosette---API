<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Kermesses;
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
}
