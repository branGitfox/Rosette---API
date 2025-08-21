<?php

namespace App\Http\Controllers;

use App\Models\Mac;
use Illuminate\Http\Request;

class MacController extends Controller
{
    //CREATION MOIS D'ANNEE SCOLAIRE
    public function create($mois, $id_ac) {
        Mac::create(['mois' => $mois, 'id_ac' => $id_ac]);
    }
}
