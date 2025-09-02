<?php

namespace App\Http\Controllers;

use App\Models\Sousetudiants;
use Illuminate\Http\Request;

class SousetudiantsController extends Controller
{
    //Cration SOUS ETUDIANT

    public function create($sa_id, $ac_id,$cl_id,$et_id, $note1,$note2,$note3){
        Sousetudiants::create([
            'sa_id' => $sa_id,
            'ac_id' => $ac_id,
            'cl_id' => $cl_id,
            'note1' => $note1,
            'note2' => $note2,
            'note3' => $note3,
            'et_id' => $et_id,
        ]);
    }
}
