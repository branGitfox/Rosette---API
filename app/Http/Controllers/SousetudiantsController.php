<?php

namespace App\Http\Controllers;

use App\Models\Admissions;
use App\Models\Sousetudiants;
use Illuminate\Http\Request;

class SousetudiantsController extends Controller
{
    //Cration SOUS ETUDIANT

    public function create($sa_id, $ac_id,$cl_id,$et_id, $note1,$note2,$note3){
        Sousetudiants::create([
            'sa_id' => $sa_id,
            'ac_id' => $ac_id,
            'cl_id' => $cl_id,
            'note1' => $note1,
            'note2' => $note2,
            'note3' => $note3,
            'noteTotal' =>NULL,
            'et_id' => $et_id,
        ]);
    }


    public function update($id, $request){
        Sousetudiants::findOrFail($id)->update($request);
    }

    public function update_note($id, Request $request){
//        return ['message' => $request->noteTotal];
       Sousetudiants::findOrFail($id)->update(['note1' => $request->note1==0?NULL:$request->note1, 'note2' => $request->note2==0?NULL:$request->note2, 'note3' => $request->note3==0?NULL:$request->note3, 'noteTotal' => $request->noteTotal==0?NULL:$request->noteTotal]);
        $sous_etudiant_updateed = Sousetudiants::findOrFail($id);

        $moyenne_admission = Admissions::where('ac_id', $sous_etudiant_updateed->ac_id)->first();

        if($sous_etudiant_updateed->note1 && $sous_etudiant_updateed->note2&&$sous_etudiant_updateed->note3&&$sous_etudiant_updateed->noteTotal){
            if($sous_etudiant_updateed->noteTotal >= $moyenne_admission->note){
                $status = 'admis';
            }else{
                $status = 'redoublé';
            }


        }else{
            $status='cours';
        }
        Sousetudiants::findOrFail($id)->update(['status_admissions' => $status]);
        return response()->json(['message' => 'note modifié']);
    }



}
