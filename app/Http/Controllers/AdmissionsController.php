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
            'ac_id' => 'required',
            'note_pre' => 'required|integer',
            'par_delib' => 'required|integer',
            'par_delib_pre' => 'required|integer',
        ],
        [
            'note.required' => 'Note est requis',
            'note.integer' => 'Note doit etre un entier',
            'note_pre.required' => 'Note prescolaire est requis',
            'note_pre.integer' => 'Note prescolaire doit etre un entier',
            'par_delib.required' => 'deliberation  est requise',
            'par_delib.integer' => 'Deliberation  doit etre un entier',
            'par_delib_pre.required' => 'deliberation prescolaire est requise',
            'par_delib_pre.integer' => 'Deliberation prescolaire doit etre un entier',
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
                'note_pre' => $fields['note_pre'],
                'par_delib' => $fields['par_delib'],
                'par_delib_pre' => $fields['par_delib_pre'],
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
            'ac_id' => 'required',
            'note_pre' => 'required|integer',
            'par_delib' => 'required|integer',
            'par_delib_pre' => 'required|integer',
        ],
        [
            'note.required' => 'Note est requis',
            'note.integer' => 'Note doit etre un entier',
            'note_pre.required' => 'Note prescolaire est requis',
            'note_pre.integer' => 'Note prescolaire doit etre un entier',
            'par_delib.required' => 'deliberation  est requise',
            'par_delib.integer' => 'Deliberation  doit etre un entier',
            'par_delib_pre.required' => 'deliberation prescolaire est requise',
            'par_delib_pre.integer' => 'Deliberation prescolaire doit etre un entier',
            'ac_id.required' => 'Annee scolaire est requis',
            ]);

            $takeAcId = Acs::where('id',$fields['ac_id'])->first()->id;
            Admissions::findOrFail($id)->update([
                'note' => $fields['note'],
                'ac_id' => $takeAcId,
                'note_pre' => $fields['note_pre'],
                'par_delib' => $fields['par_delib'],
                'par_delib_pre' => $fields['par_delib_pre'],
            ]);

            $message = 'Modification d\'une Admission';
            $audit->listen('Paramètres', $message, $request->user()->id);
            return response()->json(['message' => 'Admission modifié']);

    }
}
