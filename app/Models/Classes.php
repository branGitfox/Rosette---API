<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Classes extends Model
{
    protected $fillable = [
        'nom_classe',
        'ac_id',
        'ecolage'
    ];
}
