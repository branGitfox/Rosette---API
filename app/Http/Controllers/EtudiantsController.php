<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Etudiants;

use App\Models\Sousetudiants;
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

        ], [
            'nom.required' => 'Le nom est obligatoire.',
            'prenom.required' => 'Le prénom est obligatoire.',
            'sexe.required' => 'Le sexe est obligatoire.',
            'dateNaissance.required' => 'La date de naissance est obligatoire.',
            'lieuNaissance.required' => 'Le lieu de naissance est obligatoire.',
            'adresse.required' => 'L’adresse est obligatoire.',
            'matricule.required' => 'Le matricule est obligatoire.',
            'enfantProf.required' => 'Veuillez indiquer si l’élève est enfant de professeur.',
            'cl_id.required' => 'La classe est obligatoire.',
            'sa_id.required' => 'La salle est obligatoire.',
        ]);

        if($request->file('photo') !== NULL){
            $file =  $request->file('photo');
            $image =  $file->store('uploads', 'public');
            $image_treated = explode('/',$image)[1];
        }else{
            $image_treated =  'default.png';
        }

        $ac_id = DB::table('acs')->latest()->first()->id;
        Etudiants::create([
            'nom' => $fields['nom'],
            'prenom'=> $fields['prenom'],
            'sexe' => $fields['sexe'],
            'dateNaissance' => $fields['dateNaissance'],
            'lieuNaissance' => $fields['lieuNaissance'],
            'adresse' => $fields['adresse'],
            'matricule' => $fields['matricule'],
            'photo' => $image_treated,
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
            'ac_id' =>$ac_id
        ]);

        $et_id = DB::table('etudiants')->latest()->first()->id;


        $montant_ecolage = DB::table('classes')->latest()->first()->ecolage;
        $montant_droit = DB::table('classes')->latest()->first()->droit;
        $montant_kermesse = DB::table('classes')->latest()->first()->kermesse;


            $sousetudiants->create($fields['sa_id'],$ac_id ,$fields['cl_id'], $et_id,NULL, NULL, NULL);

        $last_sousetudiant = DB::table('sousetudiants')->latest()->first()->id;
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
        return response()->json(['message' => 'Etudiant inscrit']);



    }


    //POUR CREER UN MATRICULE UNIQUE D'UN ETUDIANT

    public function matricule() {
        return response()->json(['matricule' => 'ROS'.date('y').'-'.(DB::table('etudiants')->latest()->first()?->id??'0')]);
    }


    //RECUPERATION DE LA LISTE D'ETUDIANT

    public function list(){
        $lignes = request()->query('lines');
        $sexe = request()->query('sexe');
        $year = request()->query('annee');
        $classe = request()->query('classe');
        $salle = request()->query('salle');
        $q = request()->query('q');
        return response()->json(Etudiants::sexe($sexe)->year($year)->classe($classe)->salle($salle)->where('nom', 'like', '%'.$q.'%')->orWhere('prenom', 'like', '%'.$q.'%')->with('sousetudiants', 'sousetudiants.classe', 'sousetudiants.salle', 'sousetudiants.annee', 'sousetudiants.ecolage')->orderBy('created_at', 'desc')->paginate($lignes));
    }

    //RECUPERATION D'UN ETUDIANT
    public function etudiant($id){
        return response()->json(Etudiants::with('sousetudiants')->findOrFail($id));
    }

    //MODIFICATION ETUDIANT
    public function updates($id, Request $request, SousetudiantsController $sousetudiants){

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

        ], [
            'nom.required' => 'Le nom est obligatoire.',
            'prenom.required' => 'Le prénom est obligatoire.',
            'sexe.required' => 'Le sexe est obligatoire.',
            'dateNaissance.required' => 'La date de naissance est obligatoire.',
            'lieuNaissance.required' => 'Le lieu de naissance est obligatoire.',
            'adresse.required' => 'L’adresse est obligatoire.',
            'matricule.required' => 'Le matricule est obligatoire.',
            'enfantProf.required' => 'Veuillez indiquer si l’élève est enfant de professeur.',
            'cl_id.required' => 'La classe est obligatoire.',
            'sa_id.required' => 'La salle est obligatoire.',
        ]);
        $etudiant = Etudiants::findOrFail($id);
        if($request->file('photo') !== NULL){
            $file =  $request->file('photo');
            $image =  $file->store('uploads', 'public');
            $image_treated = explode('/',$image)[1];
        }else{
            $image_treated = $etudiant->photo; ;
        }
        $etudiant->update([
            'nom' => $fields['nom'],
            'prenom'=> $fields['prenom'],
            'sexe' => $fields['sexe'],
            'dateNaissance' => $fields['dateNaissance'],
            'lieuNaissance' => $fields['lieuNaissance'],
            'adresse' => $fields['adresse'],
            'matricule' => $fields['matricule'],
            'photo' => $image_treated,
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
        $sous_et = Sousetudiants::where('et_id', $request->id)->latest()->first()->id;
        $sousetudiants->update($sous_et,['cl_id' => $request->cl_id, 'sa_id' => $request->sa_id]);
        return response()->json(['message' => 'Etudiant modifie']);
    }


//SUPPRESSION ETUDIANT

public function deletes($id){
        Etudiants::findOrFail($id)->delete();
        return response()->json(['message' => 'Etudiant supprime']);
}



}
