<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Classes extends Model
{
    protected $fillable = [
        'nom_classe',
        'ac_id',
        'ecolage',
        'droit',
        'kermesse',
        'droit_ancien',
        'kermesse_ancien',
        'niveau'
    ];

    public function acs() {
        return $this->belongsTo('App\Models\Acs', 'ac_id', 'id');
    }

    public function salles(){
        return $this->hasMany(Salles::class, 'cl_id', 'id');
    }

    public function student(){
        return $this->hasMany(Sousetudiants::class, 'cl_id', 'id');
    }
}
