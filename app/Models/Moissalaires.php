<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Moissalaires extends Model
{
    protected $fillable = [
      'mois',
      'ac_id',
      'payé',
        'w_id',
    ];
}
