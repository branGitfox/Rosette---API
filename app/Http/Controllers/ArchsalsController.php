<?php

namespace App\Http\Controllers;

use App\Models\Archsals;
use Illuminate\Http\Request;

class ArchsalsController extends Controller
{
    public function save($montant, $mois, $type, $ac_id, $w_id, $motif){
        Archsals::create([
            'montant' => $montant * count(explode(',',$mois)),
            'mois' => $mois,
            'type' => $type,
            'ac_id' => $ac_id,
            'w_id' => $w_id,
            'motif' => $motif
        ]);
    }
}
