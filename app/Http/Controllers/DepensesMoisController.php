<?php

namespace App\Http\Controllers;

use App\Models\Depensesparmois;
use Illuminate\Http\Request;

class DepensesMoisController extends Controller
{
    public function increment($ac_id, $mois,  $depense){

        if(Depensesparmois::where('ac_id', $ac_id)->where('mois', $mois)->exists()){
            $last_solde = Depensesparmois::where('ac_id', $ac_id)->where('mois', $mois)->first()->solde;
            Depensesparmois::where('ac_id', $ac_id)->where('mois', $mois)->update([
                'solde' => $last_solde + $depense
            ]);
        }else{
            Depensesparmois::create([
                'ac_id' => $ac_id,
                'solde' => $depense,
                'mois' => $mois
            ]);
        }
    }

    public function create(Request $request){
        for($i =1; $i < 13; $i++){
            $this->increment(1,$i, 10000);
        }
    }
}
