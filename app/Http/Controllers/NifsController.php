<?php

namespace App\Http\Controllers;

use App\Models\Nifs;
use Error;
use Exception;
use Illuminate\Http\Request;

class NifsController extends Controller
{
    //CREATION DE NIFS
    public function create(Request $request, AuditsController $audit){
        $fields = $request->validate([
            'nif' => 'required',
        ]);

        if(Nifs::all()->count() > 0){
             return throw new Error('Nif existente');
        }else{
            Nifs::create($fields);
            $message = 'Creation du NIF';
            $audit->listen('Paramètres', $message, $request->user()->id);
            return response()->json(['message' => 'Nif creé']);
        }
    }

    public function list(){
        return response()->json(Nifs::all());
    }


    public function deletes($id){
        Nifs::findOrFail($id)->delete();
        return response()->json(['message' => 'Nif supprimé']);
    }

    public function updates($id, Request $request, AuditsController $audit){
        $fields = $request->validate([
            'nif' => 'required',
        ]);
        Nifs::findOrFail($id)->update($fields);
        $message = 'Modification du NIF';
        $audit->listen('Paramètres', $message, $request->user()->id);
        return response()->json(['message' => 'Nif modifié']);
    }
}
