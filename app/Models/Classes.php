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

    ];

    public function acs() {
        return $this->belongsTo('App\Models\Acs', 'ac_id', 'id');
    }
}
