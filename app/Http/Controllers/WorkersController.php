<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Archconges;
use App\Models\Workers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class WorkersController extends Controller
{
    public function create( Request $request, MoissalairesController $moissalaires, MatieresController $matieres){
        $fields = $request->validate([
            'nom' => 'required',
            'prenom' => 'required',
            'sexe' => 'required',
            'email' => 'required|unique:workers',
            'adresse' => 'required',
            'salaire_base' => 'required',
            'p_id' => 'required|exists:professions,id',
            'telephone' => 'required',
//           'ac_id' => 'required',
//            'status' => 'required',

        ]);
        $ac_id = DB::table('acs')->latest()->first()->id;
        if($request->file('photo') !== NULL){
            $file =  $request->file('photo');
            $image =  $file->store('uploads', 'public');
            $image_treated = explode('/',$image)[1];
        }else{
            $image_treated =  'default.png';
        }
        Workers::create([
            'nom' => $fields['nom'],
            'prenom' => $fields['prenom'],
            'sexe' => $fields['sexe'],
            'email' => $fields['email'],
            'adresse' => $fields['adresse'],
            'ac_id' => $ac_id,
            'salaire_base' => $fields['salaire_base'],
            'p_id' => $fields['p_id'],
            'photo' => $image_treated,
            'telephone' => $fields['telephone'],
        ]);
        $w = Workers::with('profs')->latest()->first();
        $w_id = $w->id;

        $mois_list = Acs::with('mois')->where('id', $ac_id)->first();


        foreach ($mois_list->mois as $m) {
            $moissalaires->initializeMoissalaires($ac_id, $w_id, $m->mois, 0);
        }

        if($w->profs->id == 1){
            foreach (json_decode($request->matiere) as $mat){
                $matieres->create($mat->matiere,$mat->salle,$w_id);

            }

        }



        return ['message' => 'Employé  creé'];
    }

    //RECUPERATION LIST EMPLOYE
    public function list(){
        $q = request()->query('q');

        return response()->json(Workers::where('nom', 'like', '%'.$q.'%')->orWhere('prenom', 'like', '%'.$q.'%')->orWhereHas('profs' , fn($f) => $f->where('profession', 'like','%'.$q.'%'))->with('profs', 'matiere')->paginate(12));
    }

    //RECUPERER UN EMPLOYE
    public function worker($id){
        return response()->json(Workers::with('profs', 'matiere')->find($id));
    }

    //MODIFICATION EMPLOYE
    public function update($id, Request $request,MatieresController $matieres){
        $fields = $request->all();
        $worker_to_modify = Workers::findOrFail($id);
        if($request->file('photo') !== NULL){
            $file =  $request->file('photo');
            $image =  $file->store('uploads', 'public');
            $image_treated = explode('/',$image)[1];
        }else{
            $image_treated =  $worker_to_modify->photo;
        }
        $worker_to_modify->update([
            'nom' => $fields['nom'],
            'prenom' => $fields['prenom'],
            'sexe' => $fields['sexe'],
            'email' => $fields['email'],
            'adresse' => $fields['adresse'],
//            'ac_id' => $ac_id,
            'salaire_base' => $fields['salaire_base'],
            'p_id' => $fields['p_id'],
            'photo' => $image_treated,
            'telephone' => $fields['telephone'],
        ]);
        $w = Workers::with('profs', 'matiere')->findOrFail($id);
        $w_id = $w->id;

        if($w->profs->id == 1){

            foreach ($w->matiere as $m){
                $matieres->delete($m->id);
            }

            foreach (json_decode($request->matiere) as $mat){
                $matieres->create($mat->matiere,$mat->salle,$w_id);
            }

        }



        return ['message' => 'Employé  modifié'];
    }

    public function delete($id){
        Workers::findOrFail($id)->delete();
        return response()->json(['message' => 'Employé supprimé']);
    }

    public function count(){
        $prof=Workers::isProf()->get()->count();
        $all = Workers::all()->count();
        return ['prof'=> ['title'=>'Enseignants', 'value' => $prof, 'icon' => 'FaChalkboardTeacher'], 'all' => ['title' => 'Employés', 'value' => $all, 'icon' => 'FaUsers']];
    }

    public function status($id, Request $request){
        Workers::where('id', $id)->update(['status' => $request->status]);
        Archconges::where('w_id', $id)->latest()->first()->update(['status' => 0]);
        return response()->json(['message' => 'Status modifié']);
    }
}
