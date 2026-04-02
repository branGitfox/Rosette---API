<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Monthbylevels extends Model
{
    protected $table = 'monthbylevels';
    protected $fillable = [
            'prescolaire',
            'primaire',
            'college'
        ];
}
