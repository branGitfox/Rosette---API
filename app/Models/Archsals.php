<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Archsals extends Model
{
    protected $fillable = [
        'montant',
        'mois',
        'type',
        'ac_id',
        'w_id',
        'motif',
    ];
}
