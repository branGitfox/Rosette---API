<?php

namespace App\Http\Controllers;

use App\Models\AcModel;
use App\Models\Acs;
use Illuminate\Http\Request;

class AcController extends Controller
{
    //CREATION D'UNE ANNEE SCOLAIRE

    public function create(Request $request) {
        $fields = $request->validate([
            'annee' => 'required|unique:acs',

        ], [
            'annee.required' => 'Annee obligatoire',
            'annee.unique' => 'Annee existe deja'

        ]);

        Acs::create($fields);

        return response()->json(['message' => 'Annee scolaire cree']);
    }
}
