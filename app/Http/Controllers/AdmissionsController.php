<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Admissions;
use Error;
use Illuminate\Http\Request;

class AdmissionsController extends Controller
{
    //CREATION REGLAGE D"ADMISSION

    public function create(Request $request, AuditsController $audit){
        $fields =$request->validate([
            'note' => 'required|integer',
            'ac_id' => 'required'
        ],
        [
            'note.required' => 'Note est requis',
            'note.integer' => 'Note doit etre un entier',
            'ac_id.required' => 'Annee scolaire est requis',
        ]);
        $ac_id = Acs::findOrFail($fields['ac_id'])->id;
       $admission =  Admissions::where('ac_id', $ac_id)->first();
        if($admission){

            throw  new Error('Note deja defini pour cette année scolaire');
        }else{
            $takeAcId = Acs::where('id',$fields['ac_id'])->first()->id;
            Admissions::create([
                'note' => $fields['note'],
                'ac_id' => $takeAcId,
            ]);

            $message = 'Creation d\'une Admission';
            $audit->listen('Paramètres', $message, $request->user()->id);
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

    public function updates($id, Request $request, AuditsController $audit){
        $fields =$request->validate([
            'note' => 'required|integer',
            'ac_id' => 'required'
        ],
            [
                'note.required' => 'Note est requis',
                'note.integer' => 'Note doit etre un entier',
                'ac_id.required' => 'Annee scolaire est requis',
            ]);

            $takeAcId = Acs::where('id',$fields['ac_id'])->first()->id;
            Admissions::findOrFail($id)->update([
                'note' => $fields['note'],
                'ac_id' => $takeAcId,
            ]);

            $message = 'Modification d\'une Admission';
            $audit->listen('Paramètres', $message, $request->user()->id);
            return response()->json(['message' => 'Admission modifié']);

    }
}
