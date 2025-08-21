<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class Acs extends Model
{

    protected $fillable = ['annee'];
    protected $table = 'acs';

}
