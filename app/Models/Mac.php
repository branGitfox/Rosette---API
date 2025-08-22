<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Mac extends Model
{
    protected $fillable = ['mois', 'id_ac'];

    public function ac(){
        return $this->belongsTo(Acs::class, 'id_ac', 'annee');
    }


}
