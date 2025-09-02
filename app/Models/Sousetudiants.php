<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sousetudiants extends Model
{
    protected $fillable  = [
        'cl_id',
        'sa_id',
        'ac_id',
        'et_id',
        'note1',
        'note2',
        'note3'
    ];
}
