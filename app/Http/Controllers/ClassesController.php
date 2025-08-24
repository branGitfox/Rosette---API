<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Classes;
use Illuminate\Http\Request;

class ClassesController extends Controller
{
    //CREATION CLASSE

    public function create(Request $request){
        $fields = $request->validate([
            'nom_classe' => 'required',
            'ac_id' => 'required',
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
        $takeAnneId = Acs::where('annee', $fields['ac_id'])->first()->id;

        Classes::create([
            'nom_classe' => $fields['nom_classe'],
            'ac_id' => $takeAnneId,
            'ecolage' => $fields['ecolage'],

        ]);
        return response()->json(['message' => "classe Creé"]);
    }

    //RECUPERATION HISTORIQUE

    public function list() {
        return response()->json([Classes::with('acs')->get()]);
    }
}
