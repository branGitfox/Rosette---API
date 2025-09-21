<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Mac;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MacController extends Controller
{
    //CREATION MOIS D'ANNEE SCOLAIRE
    public function create($mois, $id_ac) {
        Mac::create(['mois' => $mois, 'id_ac' => $id_ac]);
    }

    //RECUPERATION MOIS PAR ANNEE

    public function list_year($id){
        if($id == 0){
            $ac_id = DB::table('acs')->latest()->first()->annee;

        }else{
            $id_ac =Acs::where('id', $id)->first()->annee;
            $ac_id = $id_ac;
        }

        return response()->json(Mac::where('id_ac', $ac_id)->orderBy('created_at', 'desc')->get());
    }
}
