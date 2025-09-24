<?php

namespace App\Http\Controllers;

use App\Models\Professions;
use Illuminate\Http\Request;

class ProfessionsController extends Controller
{
    //CREATION DE PROFESSION
    public function create(Request $request){
        $fields = request()->validate([
            'profession' => 'required',
        ]);

        Professions::create($fields);
        return response()->json(['message' => 'profession creéée']);
    }


    //RECUPERATION DE PROFESSION
    public function list(){
        return Professions::all();
    }

}
