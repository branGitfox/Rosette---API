<?php

namespace App\Http\Controllers;

use App\Models\Classes;
use App\Models\Salles;
use Illuminate\Http\Request;

class SallesController extends Controller
{
    //CREATION SALLES
    public function create(Request $request){
        $fields = $request->validate([
            'nom_salle' => 'required',
            'effectif' => 'required|integer',
            'ac_id' => 'required|exists:acs,id',
            'cl_id' => 'required|exists:classes,id',
        ],


        [
            'nom_salle.required' => 'Le nom de la salle est obligatoire',
            'effectif.required' => 'L\'effectif est obligatoire',
            'effectif.integer' => 'L\'effectif doit etre un nombre entier',
            'ac_id.required' => 'L\'ac_id est obligatoire',
            'ac_id.exists' => 'L\'annee scolaire n\'existe pas',
            'cl_id.required' => 'Le CL_id est obligatoire',
            'cl_id.exists' => 'Le CL_id n\'existe pas',
        ]
        );

        Salles::create($fields);

        return response()->json(['message' => 'Salle de classe creé']);



    }


    //RECUPERATION HISTORIQUE
    public function list(){
        return response()->json(Salles::with('classes')->get());
    }
}
