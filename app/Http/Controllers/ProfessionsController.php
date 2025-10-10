<?php

namespace App\Http\Controllers;

use App\Models\Professions;
use Illuminate\Http\Request;

class ProfessionsController extends Controller
{
    //CREATION DE PROFESSION
    public function create(Request $request, AuditsController $audit){
        $fields = $request->validate([
            'profession' => 'required',
        ]);

        Professions::create($fields);
        $message = 'Creation d\'une profession';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => 'profession creéée']);
    }


    //RECUPERATION DE PROFESSION
    public function list(){
        return Professions::all();
    }

    public function deletes($id){
        Professions::findOrFail($id)->delete();
        return response()->json(['message' => 'Profession supprimé']);
    }

    public function updates($id, Request $request, AuditsController $audit){
        $fields = $request->validate([
            'profession' => 'required',
        ]);
        $message = 'Modification d\'une profession';
        Professions::findOrFail($id)->update($fields);
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => 'profession modifiée']);
    }

}
