<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class Acs extends Model
{

    protected $fillable = ['annee', 'debut'];

    public function mois() {
        return $this->hasMany('App\Models\Mac', 'id_ac', 'annee');
    }


}
