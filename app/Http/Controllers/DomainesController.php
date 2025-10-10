<?php

namespace App\Http\Controllers;

use App\Models\Domaines;
use Illuminate\Http\Request;

class DomainesController extends Controller
{

    public function create(Request $request, AuditsController $audit){
        $fields = $request->validate([
            'nom' => 'required',
        ]);

            Domaines::create($fields);
        $message = 'Création d\'une matiere';
        $audit->listen('Paramètres', $message, $request->user()->id);
            return response()->json(['message' => 'Matiere creé']);
    }

    public function list(){
        return response()->json(Domaines::all());
    }

    public function deletes($id){
        Domaines::findOrFail($id)->delete();
        return response()->json(['message' => 'Matiere supprimé']);
    }

    public function updates($id, Request $request, AuditsController $audit){
        $fields = $request->validate([
            'nom' => 'required',
        ]);
        $message = 'Modification d\'une matiere';
        $audit->listen('Paramètres', $message, $request->user()->id);
        Domaines::findOrFail($id)->update($fields);
        return response()->json(['message' => 'Matiere modifié']);
    }
}
