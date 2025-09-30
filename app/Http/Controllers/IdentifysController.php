<?php

namespace App\Http\Controllers;

use App\Models\Identifys;
use Error;
use Illuminate\Http\Request;

class IdentifysController extends Controller
{
    //CREATION DE NUMBERO D'IDENTIFICATION
    public function create(Request $request){
        $fields = $request->validate([
            'ident' => 'required',
        ]);

        if(Identifys::all()->count() > 0){
            return throw new Error('Numero d\'identification existe Deja');
        }else{
            Identifys::create($fields);
            return response()->json(['message' => 'Numero d\'identification creé']);
        }
    }

    public function deletes($id){
        Identifys::findOrFail($id)->delete();
        return response()->json(['message' => 'Stat supprimé']);
    }


    public function list(){
        return response()->json(Identifys::all());
    }
}
