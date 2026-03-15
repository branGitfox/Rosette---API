<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Moisecolage extends Model
{
    protected $fillable = [
        'ac_id',
        'et_id',
        'mois',
        'payé',
        'reste',
        'paid',
    ];


    public function history(){
        return $this->hasMany(Ecohistos::class, 'ec_id', 'id');
    }
}
