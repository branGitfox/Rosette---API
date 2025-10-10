<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Classes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClassesController extends Controller
{
    //CREATION CLASSE

    public function create(Request $request, AuditsController $audit){
        $fields = $request->validate([
            'nom_classe' => 'required',
            'ac_id' => 'required',
            'ecolage' => 'required|integer',
            'droit' => 'required|integer',
            'kermesse' => 'required|integer',

        ],

        [
            'nom_classe.required' => 'Nom de la classe   obligatoire',
            'ac_id.required' => 'Anne scolaire  obligatoire',
            'ac_id.exists' => 'Cette Annee Scolaire n\'existe pas',
            'ecolage.required' => 'Ecolage  obligatoire',
            'ecolage.integer' => 'Ecolage doit etre en chiffre',
            'droit.required' => 'Droit  obligatoire',
            'droit.integer' => 'Droit doit etre en chiffre',
            'kermesse.required' => 'Kermesse  obligatoire',
            'kermesse.integer' => 'Kermesse doit etre en chiffre'
        ]
        );
        $takeAnneId = Acs::where('annee', $fields['ac_id'])->latest()->first()->id;

        Classes::create([
            'nom_classe' => $fields['nom_classe'],
            'ac_id' => $takeAnneId,
            'ecolage' => $fields['ecolage'],
            'droit' => $fields['droit'],
            'kermesse' => $fields['kermesse'],

        ]);
        $message = 'Creation d\'une classe';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => "classe Creé"]);
    }

    //RECUPERATION HISTORIQUE

    public function list() {
        return response()->json(Classes::with('acs')->get());
    }

    //RECUPERATION CLASSE PAR ANNEE

    Public function list_year($id){
        if($id == 0){
            $ac_id = DB::table('acs')->latest()->first()->id;

        }else{
            $ac_id = $id;
        }

        return response()->json(Classes::where('ac_id', $ac_id)->orderBy('created_at', 'desc')->get());
    }
    public function delete($id){
        Classes::findOrFail($id)->delete();

        return response()->json(['message' => 'Classe supprimé']);
    }

    public function updates($id, Request $request, AuditsController $audit){
        $fields = $request->validate([
        'nom_classe' => 'required',
        'ac_id' => 'required',
        'ecolage' => 'required|integer|max:999999999',
        'droit' => 'required|integer|max:999999999',
        'kermesse' => 'required|integer|max:999999999',

    ],
        [
            'nom_classe.required' => 'Nom de la classe obligatoire',
            'ac_id.required' => 'Année scolaire obligatoire',
            'ac_id.exists' => 'Cette année scolaire n\'existe pas',

            'ecolage.required' => 'Ecolage obligatoire',
            'ecolage.integer' => 'Ecolage doit être un chiffre',
            'ecolage.max' => 'Ecolage ne doit pas dépasser 999999999',

            'droit.required' => 'Droit obligatoire',
            'droit.integer' => 'Droit doit être un chiffre',
            'droit.max' => 'Droit ne doit pas dépasser 999999999',

            'kermesse.required' => 'Kermesse obligatoire',
            'kermesse.integer' => 'Kermesse doit être un chiffre',
            'kermesse.max' => 'Kermesse ne doit pas dépasser 999999999',
        ]);

        Classes::findOrFail($id)->update([
            'nom_classe' => $fields['nom_classe'],
            'ac_id' => $fields['ac_id'],
            'ecolage' => $fields['ecolage'],
            'droit' => $fields['droit'],
            'kermesse' => $fields['kermesse'],

        ]);
        $message = 'Modification d\'une classe';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => "classe Creé"]);
    }
}
