<?php

namespace App\Http\Controllers;

use App\Models\Ecolages;
use App\Models\Etudiants;
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
}
