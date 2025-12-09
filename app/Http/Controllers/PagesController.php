<?php

namespace App\Http\Controllers;

use App\Models\Pages;
use Illuminate\Http\Request;

class PagesController extends Controller
{
    //CREATION D'UNE PAGE
    public function create(Request $request){

        $validated = $request->validate([
            'page_name' => 'required',
        ],
        ['page_name.required' => "Le nom de la page est obligatoire"]
        );

        Pages::create($validated);

        return response()->json(['message' => 'Page creée']);
    }

    public function edit(Pages $page, Request $request){

        $validated = $request->validate([
            'page_name' => 'required',
        ], ['page_name.required' => "Le nom de la page est obligatoire"]);

        $page->update($validated);

        return response()->json(['message' => 'Page modifié']);
    }


    public function destroy(Pages $page){
        $page->delete();
        return response()->json(['message' => 'Page supprimé']);
    }

    public function getPages(){
        return response()->json(Pages::all());
    }
}
