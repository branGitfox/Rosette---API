<?php

namespace App\Http\Controllers;

use App\Models\Moisecolage;
use Illuminate\Http\Request;

class MoisecolageController extends Controller
{
    //INITIALISE LES MOIS D'ECOLAGE D'UNE ANNE_SCOLAIRE
    public function initializeMoisecolage($ac_id, $et_id, $mois, $payé){
        Moisecolage::create([
            'ac_id' => $ac_id,
            'et_id' => $et_id,
            'mois' => $mois,
            'payé' => $payé
        ]);
    }
}
