<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Depensesparmois extends Model
{
    protected $fillable = ['ac_id', 'mois', 'solde'];
    public function scopePeriod($query, $start, $end) {
        if($start!=='null' && $end!=='null'){
            return $query->whereDate('created_at', '>=', $start)->whereDate('created_at', '<=', $end);
        }else{
            return $query;
        }

    }
}
