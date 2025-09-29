<?php

namespace App\Http\Controllers;

use App\Models\Depenses;
use Illuminate\Http\Request;

class DepensesController extends Controller
{
    //INCREMENTATION DU SOLDE PAR RAPPORT A MONTANT QUI CORRESPOND AU NIVEAU DU NOUVEAU ETUDIANT

    public function increment($ac_id, $depense){

        if(Depenses::where('ac_id', $ac_id)->exists()){
            $last_solde = Depenses::where('ac_id', $ac_id)->first()->solde;
            Depenses::where('ac_id', $ac_id)->update([
                'solde' => $last_solde + $depense
            ]);
        }else{
            Depenses::create([
                'ac_id' => $ac_id,
                'solde' => $depense
            ]);
        }
    }
}
