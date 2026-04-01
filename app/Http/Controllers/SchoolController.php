<?php

namespace App\Http\Controllers;

use App\Models\School;
use http\Env\Response;
use Illuminate\Http\Request;

class SchoolController extends Controller
{
    //Pour la creation du titre de l'etablissement

    public function create(Request $request, AuditsController $audit){
        $validated = $request->validate([
            'name' => 'required',
            'owner' => 'required',
            'telephone' => 'required',
            'email' => 'required',
            'adresse' => 'required',
            'decision' => 'required',
            'code' => 'required'

        ],

        [
            'name.required' => 'Le nom est requis',
            'owner.required' => 'Le nom est requis',
            'decision.required' => 'Le nom est requis',
            'code.required' => 'Le nom est requis',
            'telephone.required' => 'Le nom est requis',
            'email.required' => 'Le nom est requis',
            'adresse.required' => 'Le nom est requis'
        ]);

        //verification si le titre de l'ecole existe deja
        $exist = School::all()->count();
        if($exist > 0){
            return response()->json(['message' => "Il existe deja une caracteristique pour cette ecole"], 401);
        }else{
            School::create($validated);
            $message = 'Ajout caracteristique d\'ecole';
            $audit->listen('Paramètres', $message, $request->user()->id);
            return response()->json(['message' => 'Caracteristique enregistré']);
        }
    }


    public function show (){
        return response()->json(School::all()[0]);
    }

    public function destroy(School $school, AuditsController $audit){
        $school->delete();
        $message = 'Suppression caracteristique d\'ecole';
        $audit->listen('Paramètres', $message, request()->user()->id);
        return response()->json(['message' => 'Caracteristique supprimé']);
    }

    public function edit(School $school, Request $request, AuditsController $audit){
        $validated = $request->validate([
            'name' => 'required',
            'owner' => 'required',
            'telephone' => 'required',
            'email' => 'required',
            'adresse' => 'required',
            'decision' => 'required',
            'code' => 'required'

        ],

            [
                'name.required' => 'Le nom est requis',
                'owner.required' => 'Le nom est requis',
                'decision.required' => 'Le nom est requis',
                'code.required' => 'Le nom est requis',
                'telephone.required' => 'Le nom est requis',
                'email.required' => 'Le nom est requis',
                'adresse.required' => 'Le nom est requis'
            ]);
        $school->update($validated);
        $message = 'Modification caracteristique d\'ecole';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => 'Caracteristique  modifié']);

    }
}
