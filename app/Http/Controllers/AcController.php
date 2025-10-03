<?php

namespace App\Http\Controllers;

use App\Models\AcModel;
use App\Models\Acs;
use App\Models\Mac;
use App\Models\Workers;
use Illuminate\Http\Request;

class AcController extends Controller
{
    //CREATION D'UNE ANNEE SCOLAIRE

    public function create(Request $request, MacController $mac, MoissalairesController $moissalaires) {
        $fields = $request->validate([
            'annee' => 'required|unique:acs',
            'mois' => 'required',
            'debut' => 'required',
        ], [
            'annee.required' => 'Annee obligatoire',
            'annee.unique' => 'Annee existe deja',
            'mois.required' => 'mois obligatoire'


        ]);

        foreach ($fields['mois'] as $mois){
            $mac->create($mois, $fields['annee']);
        }

        Acs::create($fields);
        $ac_id = Acs::latest()->first()->id;
        $mois_list = Acs::with('mois')->where('id', $ac_id)->first();
        if(Workers::all()->count() > 0){
            foreach(Workers::all() as $w){
                foreach ($mois_list?->mois as $m) {
                    $moissalaires->initializeMoissalaires($ac_id, $w?->id, $m->mois, 0, $w?->salaire_base);
                }
            }
        }


        return response()->json(['message' => 'Annee scolaire cree']);
    }


    //RECUPERATION DE L'HISTORIQUE DE CREATION AVEC MOIS
    public function list(){
        return response()->json(Acs::query()->orderByDesc('created_at')->with(['mois'])->get());
    }

    //SUPPRESSION ANNE SCOLAIRE AVEC MOIS
    public function delete($id){
       $acs = Acs::findOrFail($id);
         Mac::query()->where('id_ac', $acs->annee)->delete();
        $acs->delete();
        return response()->json(['message' => 'Annee Scolaire supprimé']);
    }


    //RECUPERATION LA LISTE D"ANNEE SCOLAIRE

    public function listAnnee() {
        return response()->json(Acs::query()->orderByDesc('created_at')->get());
    }

}
