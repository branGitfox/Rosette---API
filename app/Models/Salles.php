<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Salles extends Model
{
    protected $fillable = [
      'nom_salle',
        'effectif',
      'ac_id',
      'cl_id',
        'created_at',
        'updated_at',
    ];

    public function classes(){
        return $this->belongsTo(Classes::class, 'cl_id', 'id');
    }

    public function eleves (){
        return $this->hasMany(Sousetudiants::class, 'sa_id', 'id');
    }
}
