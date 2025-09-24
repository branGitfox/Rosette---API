<?php

namespace App\Http\Controllers;

use App\Models\Matieres;
use Illuminate\Http\Request;

class MatieresController extends Controller
{
    //CREATION MATIERE
    public function create($matiere,$salle, $w_id){
        Matieres::create([
            'w_id' => $w_id,
            'matiere' => $matiere,
            'salle' => $salle
        ]);
    }

    public function delete($id){
        Matieres::findOrFail($id)->delete();
    }
}
