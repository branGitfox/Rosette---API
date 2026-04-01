<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class School extends Model
{
    protected $table = 'schools';
    protected $fillable = [
        'name',
        'owner',
        'telephone',
        'email' ,
        'adresse',
        'decision' ,
        'code'
    ];
}
