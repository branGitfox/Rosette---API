<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ecohistos extends Model
{
    protected $fillable = ['montant', 'ec_id', 'type', 'reste'];
    public function ecol(){
        return $this->belongsTo(Moisecolage::class, 'ec_id', 'id');
    }
}
