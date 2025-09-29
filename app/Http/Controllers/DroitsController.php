<?php

namespace App\Http\Controllers;

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
        $droits = Droits::all();
        $total = 0;

        foreach ($droits as $droit) {
            $total+=$droit->solde;
        }

        return response()->json(['title' => 'Solde de droits', 'value' => $total, 'icon' => 'FaWallet']);
    }
}
