<?php

namespace App\Http\Controllers;

use App\Models\Moissalaires;
use Illuminate\Http\Request;

class MoissalairesController extends Controller
{
    public function initializeMoissalaires($ac_id, $w_id, $mois, $payé){
        Moissalaires::create([
            'ac_id' => $ac_id,
            'w_id' => $w_id,
            'mois' => $mois,
            'payé' => $payé
        ]);
    }
}
