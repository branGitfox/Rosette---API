<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Classes;
use App\Models\Etudiants;

use App\Models\Salles;
use App\Models\Sousetudiants;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class EtudiantsController extends Controller
{
    //INSCRIPTION D'UN ETUDIANT

    public function inscription(Request $request, SousetudiantsController $sousetudiants,AuditsController $audit, EcolageController $ecolage, DroitsController $droit, KermessesController $kermesse, MoisecolageController $moisecolage, RevenusMoisController $revenusmois){
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
        if(Sousetudiants::where('sa_id', $fields['sa_id'])->count() == Salles::where('id', $fields['sa_id'])->first()->effectif){
            throw new \Error('La salle a atteint son effectif');
        }else{
            if($request->file('photo') !== NULL){
                $file =  $request->file('photo');
                $image =  $file->store('uploads', 'public');
                $image_treated = explode('/',$image)[1];
            }else{
                $image_treated =  'default.png';
            }

            $ac_id = DB::table('acs')->latest()->first()->id;
            $debut_mois = DB::table('acs')->latest()->first()->debut;
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
            $enfant_prof = DB::table('etudiants')->latest()->first()->enfantProf;


            $montant_ecolage = DB::table('classes')->latest()->first()->ecolage;
            $montant_droit = DB::table('classes')->latest()->first()->droit;
            $montant_kermesse = DB::table('classes')->latest()->first()->kermesse;


            $sousetudiants->create($fields['sa_id'],$ac_id ,$fields['cl_id'], $et_id,0, 0, 0);

            $last_sousetudiant = DB::table('sousetudiants')->latest()->first()->id;
            $ecolage->increment($ac_id, $montant_ecolage / ($enfant_prof==1?2:1));
            $droit->increment($ac_id, $montant_droit);
            $kermesse->increment($ac_id, $montant_kermesse);
            $mois_list = Acs::with('mois')->where('id', $ac_id)->first();

            foreach($mois_list->mois as  $m){
                if($debut_mois === $m->mois){
                    $payé = true;
                    $revenusmois->increment($ac_id,$m->mois, ($montant_ecolage / ($enfant_prof==1?2:1))+$montant_droit+$montant_kermesse);
                }else{
                    $payé = false;
                }

                $moisecolage->initializeMoisecolage($ac_id, $last_sousetudiant, $m->mois, $payé);
            }


            $message = 'Inscription d\'un etudiant';
            $audit->listen('Étudiants', $message, $request->user()->id);
            return response()->json(['message' => 'Etudiant inscrit']);
        }




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
        return response()->json(Etudiants::where('nom', 'like', '%'.$q.'%')->orWhere('prenom', 'like', '%'.$q.'%')->sexe($sexe)->year($year)->classe($classe)->salle($salle)->with('sousetudiants', 'sousetudiants.classe', 'sousetudiants.salle', 'sousetudiants.annee', 'sousetudiants.ecolage')->orderBy('created_at', 'desc')->paginate($lignes));
    }

    //RECUPERATION DE LA LISTE D'ETUDIANT PAGE GESTION NOTE

    public function list_note(){
        $lignes = request()->query('lines');
        $sexe = request()->query('sexe');
        $year =request()->query('annee') == 0?DB::table('acs')->latest()->first()->id:request()->query('annee');
        $classe = request()->query('classe');
        $salle = request()->query('salle');
        $q = request()->query('q');
        $mention = request()->query('mention');
        return response()->json(Etudiants::where('nom', 'like', '%'.$q.'%')->orWhere('prenom', 'like', '%'.$q.'%')->sexe($sexe)->yearNote($year)->mention($mention)->classe($classe)->salle($salle)->with(['sousetudiants' => fn($q) => $q->where('ac_id', $year)->with(['classe', 'salle', 'annee', 'ecolage'])  ])->orderBy('created_at', 'desc')->paginate($lignes));
    }

    //RECUPERATION D'UN ETUDIANT
    public function etudiant($id){
        return response()->json(Etudiants::with('sousetudiants')->findOrFail($id));
    }

    //MODIFICATION ETUDIANT
    public function updates($id, Request $request, SousetudiantsController $sousetudiants, AuditsController $audit){

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

        if(Sousetudiants::where('sa_id', $fields['sa_id'])->where('et_id', '!=', $request->id)->count() == Salles::where('id', $fields['sa_id'])->first()->effectif){
            throw new \Error('La salle a atteint son effectif');
        }else {
            $etudiant = Etudiants::findOrFail($id);
            if ($request->file('photo') !== NULL) {
                $file = $request->file('photo');
                $image = $file->store('uploads', 'public');
                $image_treated = explode('/', $image)[1];

            } else {
                $image_treated = $etudiant->photo;

            }
            $etudiant->update([
                'nom' => $fields['nom'],
                'prenom' => $fields['prenom'],
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
            $sousetudiants->update($sous_et, ['cl_id' => $request->cl_id, 'sa_id' => $request->sa_id]);
            $message = 'Modification d\'un etudiant';
            $audit->listen('Étudiants', $message, $request->user()->id);
            return response()->json(['message' => 'Etudiant modifie']);

        }
    }


//SUPPRESSION ETUDIANT

public function deletes($id, Request $request, AuditsController $audit) {
        Etudiants::findOrFail($id)->delete();
    $message = 'Reinscription d\'un etudiant';
    $audit->listen('Étudiants', $message, $request->user()->id);
        return response()->json(['message' => 'Etudiant supprime']);
}

//REINSCRIPTION ETUDIANT
 public function reinscriptions(Request $request, SousetudiantsController $sousetudiants_instance,AuditsController $audit, EcolageController $ecolage, DroitsController $droit, KermessesController $kermesse, MoisecolageController $moisecolage, RevenusMoisController $revenusmois){
     if(Sousetudiants::where('sa_id', $request->sa_id)->count() == Salles::where('id', $request->sa_id)->first()->effectif){
         throw new \Error('La salle a atteint son effectif');
     }else {
         $etudiant = Etudiants::findOrFail($request->etid);
         $sousetudiant = Sousetudiants::findOrFail($request->setid);
         $salle = Salles::where('id', $request->sa_id)->with('classes')->first();
         $sa_id = $salle->id;
         $cl_id = $salle->classes->id;
         $ac_id = $salle->classes->ac_id;
         $et_id = $etudiant->id;
         $debut_mois = Acs::latest()->first()->debut;
         $sousetudiants_instance->create($sa_id, $ac_id, $cl_id, $et_id, 0, 0, 0);
         $montant_ecolage = DB::table('classes')->latest()->first()->ecolage;
         $ecolage_devide = $montant_ecolage / ($etudiant->enfantProf == 1 ? 2 : 1);
         $montant_droit = DB::table('classes')->latest()->first()->droit;
         $montant_kermesse = DB::table('classes')->latest()->first()->kermesse;
         $last_sousetudiant = DB::table('sousetudiants')->latest()->first()->id;
         $ecolage->increment($ac_id, $ecolage_devide);
         $droit->increment($ac_id, $montant_droit);
         $kermesse->increment($ac_id, $montant_kermesse);

         $mois_list = Acs::with('mois')->where('id', $ac_id)->first();

         foreach ($mois_list->mois as $m) {
             if ($debut_mois === $m->mois) {
                 $revenusmois->increment($ac_id,$m->mois, $ecolage_devide+$montant_droit+$montant_kermesse);
                 $payé = true;
             } else {
                 $payé = false;
             }

             $moisecolage->initializeMoisecolage($ac_id, $last_sousetudiant, $m->mois, $payé);
         }

         $sousetudiant->update(['transfert' => true]);
         $message = 'Reinscription d\'un etudiant';
         $audit->listen('Étudiants', $message, $request->user()->id);
         return response()->json(['message' => 'Etudiant transferé']);
     }
}

//SUSPENDRE UN ELEVE

public function suspendre($id, Request $request, AuditsController $audit){
      Sousetudiants::where('et_id', $id)->latest()->first()->update(['status_admissions' => 'suspendu', 'transfert' => true]);
    $message = 'Suspendre un etudiant';
    $audit->listen('Étudiants', $message, $request->user()->id);
      return response()->json(['message' => 'Etudiant suspendu']);
}



    //RECUPERATION DE LA LISTE D'ETUDIANT PAGE GESTION ECOLAGE

    public function list_ecolage(){

        $lignes = request()->query('lines');
        $sexe = request()->query('sexe');
        $year =request()->query('annee') == 0?DB::table('acs')->latest()->first()->id:request()->query('annee');
        $classe = request()->query('classe');
        $salle = request()->query('salle');
        $q = request()->query('q');
        $mention = request()->query('mention');
        $ecolage = request()->query('ecolage');
        $mois = request()->query('mois');
        return response()->json(Etudiants::where('nom', 'like', '%'.$q.'%')->orWhere('prenom', 'like', '%'.$q.'%')->sexe($sexe)->moisecolage($mois, $ecolage)->yearNote($year)->ecolage($ecolage)->mention($mention)->classe($classe)->salle($salle)->with(['sousetudiants' => fn($q) => $q->where('ac_id', $year)->with(['classe', 'salle', 'annee', 'ecolage'])  ])->orderBy('created_at', 'desc')->paginate($lignes));
    }


    //NOMBRE D'ETUDIANT
    public function count(){

        $count = Etudiants::all()->count();
        return response()->json(['title' => 'Etudiants', 'value' => $count, 'icon' => 'FaUserGraduate']);
    }

    public function effectif(WorkersController $worker){
        $boy = Etudiants::isGenre(1)->get()->count();
        $girl = Etudiants::isGenre(0)->get()->count();

        return response()->json([
            'labels' => ['Garçons', 'Filles', 'Enseignants', 'Employés'],
            'datasets' => [
                [
                'label' => 'Répartition',
                'data' => [$boy,$girl , $worker->count()['prof']['value'], $worker->count()['all']['value']
                ],
                'backgroundColor' => ['#895256', '#9f7126', '#3b82f6', '#10b981'],
                'borderColor'=>'#fff',
                    'borderWidth' => 2]
            ]]);
    }
}
