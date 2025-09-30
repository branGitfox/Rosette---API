<?php

namespace App\Http\Controllers;

use App\Models\Domaines;
use Illuminate\Http\Request;

class DomainesController extends Controller
{

    public function create(Request $request){
        $fields = $request->validate([
            'nom' => 'required',
        ]);

            Domaines::create($fields);
            return response()->json(['message' => 'Matiere creé']);
    }

    public function list(){
        return response()->json(Domaines::all());
    }

    public function deletes($id){
        Domaines::findOrFail($id)->delete();
        return response()->json(['message' => 'Matiere supprimé']);
    }
}
