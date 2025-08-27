<?php

namespace App\Http\Controllers;

use App\Models\Admissions;
use Illuminate\Http\Request;

class AdmissionsController extends Controller
{
    //CREATION REGLAGE D"ADMISSION

    public function create(Request $request){
        $fields =$request->validate([
            'note' => 'required|integer',
            'ac_id' => 'required|exists:acs,id'
        ],
        [
            'note.required' => 'Note est requis',
            'note.integer' => 'Note doit etre un entier',
            'ac_id.required' => 'Annee scolaire est requis',
            'ac_id.exists' => 'Annee scolaire n\'existe pas'
        ]);

       $admission =  Admissions::where('ac_id', $fields['ac_id'])->first();
        if($admission){
            return response()->json(['message' => 'Note deja defini pour cette année scolaire']);
        }else{
            Admissions::create($fields);
            return response()->json(['message' => 'Admission creé']);
        }
    }

    public function list(){
        return response()->json(Admissions::with('acs')->get());
    }

    public function delete($id){
        Admissions::findOrFail($id)->delete();
        return response()->json(['message' => 'Reglage supprimé']);
    }

}
