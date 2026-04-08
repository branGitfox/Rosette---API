<?php

namespace App\Http\Controllers;

use App\Models\Monthbylevels;
use Illuminate\Http\Request;

class MonthbylevelsController extends Controller
{
    public function creates(Request $request, AuditsController $audit){
        $fields = $request->validate([
            'prescolaire' => 'required',
            'primaire' => 'required',
            'college' => 'required',
        ],
            [
                'prescolaire.required' => 'Le champ préscolaire est obligatoire.',
                'primaire.required'   => 'Le champ primaire est obligatoire.',
                'college.required'    => 'Le champ collège est obligatoire.',
            ]
        );

        if (Monthbylevels::all()->count() > 0) {
            throw new \Error('Mois d\'année scolaire existe deja');
        }

        Monthbylevels::create($fields);
        $message = "Mois d'année scolaire creé";
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(["message" => "mois d'année scolaire creé"]);
    }

    public function updates($id, Request $request, AuditsController $audit){
        $fields = $request->validate([
            'prescolaire' => 'required',
            'primaire' => 'required',
            'college' => 'required',
        ],
            [
                'prescolaire.required' => 'Le champ préscolaire est obligatoire.',
                'primaire.required'   => 'Le champ primaire est obligatoire.',
                'college.required'    => 'Le champ collège est obligatoire.',
            ]
        );


        Monthbylevels::findOrFail($id)->update($fields);
        $message = "Mois d'année scolaire modifié";
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(["message" => "mois d'année scolaire modifié"]);
    }

    public function deletes($id, AuditsController $audit){

        Monthbylevels::findOrFail($id)->delete();
        $message = "Mois d'année scolaire supprimé";
        $audit->listen('Paramètres', $message, request()->user()->id);
        return response()->json(["message" => "mois d'année scolaire supprimé"]);
    }

    public function show(){
         return response()->json(Monthbylevels::latest()->get());
    }
}
