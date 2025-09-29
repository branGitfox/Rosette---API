<?php

namespace App\Http\Controllers;

use App\Models\Revenus;
use Illuminate\Http\Request;

class RevenusController extends Controller
{
    //INCREMENTATION DU SOLDE PAR RAPPORT A MONTANT QUI CORRESPOND AU NIVEAU DU NOUVEAU ETUDIANT

    public function increment($ac_id, $revenus){

        if(Revenus::where('ac_id', $ac_id)->exists()){
            $last_solde = Revenus::where('ac_id', $ac_id)->first()->solde;
            Revenus::where('ac_id', $ac_id)->update([
                'solde' => $last_solde + $revenus
            ]);
        }else{
            Revenus::create([
                'ac_id' => $ac_id,
                'solde' => $revenus
            ]);
        }
    }
}
