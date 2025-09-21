<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Classes;
use App\Models\Salles;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SallesController extends Controller
{
    //CREATION SALLES
    public function create(Request $request){
        $fields = $request->validate([
            'nom_salle' => 'required',
            'effectif' => 'required|integer',
//            'ac_id' => 'required|exists:acs,id',
            'cl_id' => 'required|exists:classes,id',
        ],


        [
            'nom_salle.required' => 'Le nom de la salle est obligatoire',
            'effectif.required' => 'L\'effectif est obligatoire',
            'effectif.integer' => 'L\'effectif doit etre un nombre entier',
//            'ac_id.required' => 'L\'ac_id est obligatoire',
//            'ac_id.exists' => 'L\'annee scolaire n\'existe pas',
            'cl_id.required' => 'Le CL_id est obligatoire',
            'cl_id.exists' => 'Le CL_id n\'existe pas',
        ]
        );

    $takeAcid = Classes::with('acs')->where('id', $fields['cl_id'])->first()->acs->id;

        Salles::create([
            'nom_salle' => $fields['nom_salle'],
            'effectif' => $fields['effectif'],
            'cl_id' => $fields['cl_id'],
            'ac_id' => $takeAcid,
        ]);

        return response()->json(['message' => 'Salle de classe creé']);



    }


    //RECUPERATION HISTORIQUE
    public function list(){
        return response()->json(Salles::with('classes')->get());
    }


    //SUPPRESSION SALLE
    public function delete($id){
        Salles::findOrFail($id)->delete();
        return response()->json(['message' => 'Salle supprimé']);
    }

    public function list_last(){
        $ac_id = DB::table('acs')->latest()->first()->id;
        return response()->json(Salles::where('ac_id', $ac_id)->orderBy('created_at', 'desc')->get());
    }

    Public function list_year($id){
        if($id == 0){
            $ac_id = DB::table('acs')->latest()->first()->id;

        }else{
            $ac_id = $id;
        }

        return response()->json(Salles::where('ac_id', $ac_id)->orderBy('created_at', 'desc')->get());
    }
}
