<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ajouts extends Model
{
    protected $fillable = [
        'motif',
        'ecolage',
        'droit',
        'kermesse',
        'ac_id'
    ];
}
