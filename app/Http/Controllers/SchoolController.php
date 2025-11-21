<?php

namespace App\Http\Controllers;

use App\Models\School;
use Illuminate\Http\Request;

class SchoolController extends Controller
{
    //Pour la creation du titre de l'etablissement

    public function create(Request $request){
        $validated = $request->validate([
            'name' => 'required',
        ],

        ['name.required' => 'Le nom est requis']);


        School::create($validated);
        return response()->json(['message' => 'Nom de l\'etablissement enregistré']);
    }
}
