<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Moisecolage extends Model
{
    protected $fillable = [
        'ac_id',
        'et_id',
        'mois',
        'payé'
    ];
}
