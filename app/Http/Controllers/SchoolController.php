<?php

namespace App\Http\Controllers;

use App\Models\School;
use http\Env\Response;
use Illuminate\Http\Request;

class SchoolController extends Controller
{
    //Pour la creation du titre de l'etablissement

    public function create(Request $request){
        $validated = $request->validate([
            'name' => 'required',
        ],

        ['name.required' => 'Le nom est requis']);

        //verification si le titre de l'ecole existe deja
        $exist = School::all()->count();
        if($exist > 0){
            return response()->json(['message' => "Il existe deja un titre pour cette ecole"], 401);
        }else{
            School::create($validated);
            return response()->json(['message' => 'Nom de l\'etablissement enregistré']);
        }
    }


    public function show (){
        return response()->json(School::all());
    }

    public function destroy(School $school){
        $school->delete();
        return response()->json(['message' => 'Titre supprimé']);
    }

    public function edit(School $school, Request $request){
        $validated = $request->validate([
            'name' => 'required',
        ]);
        $school->update($validated);
        return response()->json(['message' => 'Titre modifié']);
    }
}
