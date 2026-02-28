<?php

namespace App\Http\Controllers;

use App\Models\Revenusparmois;
use Illuminate\Http\Request;

class RevenusMoisController extends Controller
{
    //
    public function increment($ac_id,$mois,  $revenus){

        if(Revenusparmois::where('ac_id', $ac_id)->where('mois', 'like', substr($mois, 0,5).'-%')->exists()){
            $last_solde = Revenusparmois::where('ac_id', $ac_id)->where('mois', 'like', substr($mois, 0,5).'-%')->first()->solde;
            Revenusparmois::where('ac_id', $ac_id)->where('mois', 'like', substr($mois, 0,5).'-%')->update([
                'solde' => $last_solde + $revenus
            ]);
        }else{
            Revenusparmois::create([
                'ac_id' => $ac_id,
                'solde' => $revenus,
                'mois' => $mois
            ]);
        }
    }

    //TEST CASE POUR LA CREATION A LA VOLE
    public function create(Request $request){
        for($i =1; $i < 13; $i++){
           $this->increment(1,$i, 10000);
        }
    }




}
