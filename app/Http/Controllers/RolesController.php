<?php

namespace App\Http\Controllers;

use App\Models\Roles;
use App\Models\Rolespages;
use Illuminate\Http\Request;

class RolesController extends Controller
{
    //CREATION D'UNE PAGE
    public function create(Request $request){

        $validated = $request->validate([
            'role_name' => 'required|unique:roles',
            'pages' => 'required',
        ],
            ['role_name.required' => "Le nom du role est obligatoire"]
        );

        $role = Roles::create($validated);
        foreach($request->pages as $page){
            Rolespages::create(['role_id' => $role->id, 'page_id' => $page]);
        }
        return response()->json(['message' => 'Role creée']);
    }

    public function edit(Roles $roles, Request $request){

        $validated = $request->validate([
            'role_name' => 'required',
            'pages' => 'required',
        ],
            ['role_name.required' => "Le nom du role est obligatoire"]);
        Rolespages::where('role_id', $roles->id)->delete();
        foreach($request->pages as $page){
            Rolespages::create(['role_id' => $roles->id, 'page_id' => $page]);
        }
        $roles->update($validated);

        return response()->json(['message' => 'Role modifié']);
    }


    public function destroy(Roles $roles){
        $roles->delete();
        return response()->json(['message' => 'Role supprimé']);
    }

    public function getRoles(){
        return response()->json(Roles::with('pages')->get());
    }

    public function show(Roles $roles){
        $role = $roles->load('pages');

        return response()->json($role->pages->pluck('id'));
    }
}
