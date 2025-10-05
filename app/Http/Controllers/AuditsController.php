<?php

namespace App\Http\Controllers;

use App\Models\Audits;
use Illuminate\Http\Request;

class AuditsController extends Controller
{
    public function listen($type, $details, $user_id ){
        Audits::create([
            'type' => $type,
            'details' => $details,
            'user_id' => $user_id
        ]);
    }


    public function list(){
        $type = request()->query('type');
        $q = request()->query('q');
        return response()->json(Audits::with('user')->where('details', 'like', '%'.$q.'%')->types($type)->whereHas('user', fn($qu) => $qu->where('name', 'like', '%'.$q.'%')->orWhere('firstname', 'like', '%'.$q.'%'))->orderByDesc('created_at')->get());
    }

    public function deletes(Request $request){
        foreach ($request->ids as $id){
            Audits::findOrFail($id)->delete();

        }
        return response()->json(['message' => 'historiques supprimé']);
    }

    public function stats (){
        $param = Audits::types('Paramètres')->get()->count();
        $etudiants = Audits::types('Étudiants')->get()->count();
        $financier = Audits::types('Financier')->get()->count();
        $worker = Audits::types('Employé')->get()->count();

        return response()->json([
            'param' => $param,
            'etudiant' => $etudiants,
            'financier' => $financier,
            'employe' => $worker
        ]);
    }
}
