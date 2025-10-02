<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Archconges extends Model
{
    protected $fillable = [
      'debut',
      'fin',
      'status',
      'ac_id',
      'w_id',
      'motif'
    ];
}
