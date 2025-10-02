<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Archconges;
use App\Models\Workers;
use Illuminate\Http\Request;

class ArchcongesController extends Controller
{
    public function create(Request $request){
        $ac_id= Acs::latest()->first()->id;
        $fields = $request->validate([
            'debut' => 'required',
//            'ac_id' => 'required',
            'motif' => 'required',
            'fin' => 'required',
//            'status' => 'nullable',
            'w_id' => 'required',
        ]);
        if(Archconges::where('w_id', $fields['w_id'])->where('status', 1)->exists()){
            throw new \Error('Un congé est deja en cours');
        }else{
            Archconges::create(
                [
                    'debut' => $fields['debut'],
                    'ac_id' => $ac_id,
                    'motif' => $fields['motif'],
                    'fin' => $fields['fin'],
//                    'status' => $fields['status'],
                    'w_id' => $fields['w_id'],
                ]
            );
            Workers::where('id', $fields['w_id'])->update([
                'status' => 'congé',
            ]);

            return response()->json(['message' => 'Congé declenché']);
        }


    }

    public function archives($id){
        return response()->json(Archconges::query()->where('w_id',$id )->orderByDesc('created_at')->get());
    }

    public function deletes($id){
       $arch = Archconges::findOrFail($id);
       Workers::findOrFail($arch->w_id)->update([
           'status' => 'actif'
       ]);
       $arch->delete();
       return response()->json(['message' => 'Congé annulé']);

    }
}
