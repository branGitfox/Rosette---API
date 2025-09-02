<?php

namespace App\Http\Controllers;

use App\Models\Etudiants;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EtudiantsController extends Controller
{
    //INSCRIPTION D'UN ETUDIANT

    public function inscription(Request $request, SousetudiantsController $sousetudiants){
        $fields = $request->validate([
            'nom' => 'required',
            'prenom' => 'required',
            'sexe' => 'required',
            'dateNaissance' => 'required',
            'lieuNaissance' => 'required',
            'adresse' => 'required',
            'matricule' => 'required',
            'enfantProf' => 'required',
            'nomPere' => 'nullable',
            'nomMere' => 'nullable',
            'telephonePere' => 'nullable',
            'telephoneMere' =>  'nullable',
            'prenomMere' => 'nullable',
            'prenomPere' => 'nullable',
            'nomTuteur' => 'nullable',
            'prenomTuteur' => 'nullable',
            'telephoneTuteur' => 'nullable',
            'ecole' => 'nullable',
            'cl_id' => 'required',
            'sa_id' =>'required',

        ]);

    $file =  $request->file('photo');

       $image =  $file->store('uploads', 'public');

        Etudiants::create([
            'nom' => $fields['nom'],
            'prenom'=> $fields['prenom'],
            'sexe' => $fields['sexe'],
            'dateNaissance' => $fields['dateNaissance'],
            'lieuNaissance' => $fields['lieuNaissance'],
            'adresse' => $fields['adresse'],
            'matricule' => $fields['matricule'],
            'photo' => explode('/',$image)[1],
            'enfantProf' => $fields['enfantProf'],
            'nomPere' => $fields['nomPere'],
            'nomMere' => $fields['nomMere'],
            'telephonePere' => $fields['telephonePere'],
            'telephoneMere' => $fields['telephoneMere'],
            'prenomMere' => $fields['prenomMere'],
            'prenomPere' => $fields['prenomPere'],
            'nomTuteur' => $fields['nomTuteur'],
            'prenomTuteur' => $fields['prenomTuteur'],
            'telephoneTuteur' => $fields['telephoneTuteur'],

        ]);

        $et_id = DB::table('etudiants')->latest()->first()->id;
        $ac_id = DB::table('acs')->latest()->first()->id;
        $sousetudiants->create($fields['sa_id'],$ac_id ,$fields['cl_id'], $et_id,NULL, NULL, NULL);
        return response()->json(['message' => 'ok']);



    }

}
