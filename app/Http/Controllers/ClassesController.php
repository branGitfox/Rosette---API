<?php

namespace App\Http\Controllers;

use App\Models\Classes;
use Illuminate\Http\Request;

class ClassesController extends Controller
{
    //CREATION CLASSE

    public function create(Request $request){
        $fields = $request->validate([
            'nom_classe' => 'required',
            'ac_id' => 'required|exists:acs,id',
            'ecolage' => 'required|integer'
        ],

        [
            'nom_classe.required' => 'Nom de la classe   obligatoire',
            'ac_id.required' => 'Anne scolaire  obligatoire',
            'ac_id.exists' => 'Cette Annee Scolaire n\'existe pas',
            'ecolage.required' => 'Ecolage  obligatoire',
            'ecolage.integer' => 'Ecolage doit etre en chiffre'
        ]
        );

        Classes::create($fields);
        return response()->json(['message' => "classe Creé"]);
    }
}
