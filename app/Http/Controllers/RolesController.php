<?php

namespace App\Http\Controllers;

use App\Models\Roles;
use Illuminate\Http\Request;

class RolesController extends Controller
{
    //CREATION D'UNE PAGE
    public function create(Request $request){

        $validated = $request->validate([
            'role_name' => 'required',
        ],
            ['role_name.required' => "Le nom du role est obligatoire"]
        );

        $role = Roles::create($validated);

        return response()->json(['message' => 'Role creée']);
    }

    public function edit(Roles $roles, Request $request){

        $validated = $request->validate([
            'role_name' => 'required',
        ],
            ['role_name.required' => "Le nom du role est obligatoire"]);
        $roles->update($validated);

        return response()->json(['message' => 'Role modifié']);
    }


    public function destroy(Roles $roles){
        $roles->delete();
        return response()->json(['message' => 'Role supprimé']);
    }

    public function getRoles(){
        return response()->json(Roles::all());
    }
}
