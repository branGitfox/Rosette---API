<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Studentkermesses extends Model
{
    use HasFactory;
    protected $table = 'studentkermesses';
    protected $fillable = ['se_id', 'reste', 'payed', 'paid'];

    public function histo(){
        return $this->hasMany(Droithistos::class, 'dr_id', 'id');
    }
}
