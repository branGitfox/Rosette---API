<?php

namespace App\Http\Controllers;

use App\Models\AcModel;
use App\Models\Acs;
use Illuminate\Http\Request;

class AcController extends Controller
{
    //CREATION D'UNE ANNEE SCOLAIRE

    public function create(Request $request, MacController $mac) {
        $fields = $request->validate([
            'annee' => 'required|unique:acs',
            'mois' => 'required'
        ], [
            'annee.required' => 'Annee obligatoire',
            'annee.unique' => 'Annee existe deja',
            'mois.required' => 'mois obligatoire'


        ]);

        foreach ($fields['mois'] as $mois){
            $mac->create($mois, $fields['annee']);
        }

        Acs::create($fields);
        return response()->json(['message' => 'Annee scolaire cree']);
    }
}
