<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Salles extends Model
{
    protected $fillable = [
      'nom_salle',
        'effectif',
      'ac_id',
      'cl_id'
    ];

    public function classes(){
        return $this->belongsTo(Classes::class, 'cl_id', 'id');
    }
}
