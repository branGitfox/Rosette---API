<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Etudiants;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EtudiantsController extends Controller
{
    //INSCRIPTION D'UN ETUDIANT

    public function inscription(Request $request, SousetudiantsController $sousetudiants, EcolageController $ecolage, DroitsController $droit, KermessesController $kermesse, MoisecolageController $moisecolage){
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
        $last_sousetudiant = DB::table('sousetudiants')->latest()->first()->id;
        $montant_ecolage = DB::table('classes')->latest()->first()->ecolage;
        $montant_droit = DB::table('classes')->latest()->first()->droit;
        $montant_kermesse = DB::table('classes')->latest()->first()->kermesse;
        $sousetudiants->create($fields['sa_id'],$ac_id ,$fields['cl_id'], $et_id,NULL, NULL, NULL);
        $ecolage->increment($ac_id, $montant_ecolage);
        $droit->increment($ac_id, $montant_droit);
        $kermesse->increment($ac_id, $montant_kermesse);
        $mois_list = Acs::with('mois')->where('id', $ac_id)->first();

        foreach($mois_list->mois as $index => $m){
            if($index === 0){
                $payé = true;
            }else{
                $payé = false;
            }

            $moisecolage->initializeMoisecolage($ac_id, $last_sousetudiant, $m->mois, $payé);
        }
        return response()->json(['message' => 'ok']);



    }

}
