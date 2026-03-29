<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Droithistos extends Model
{

    protected $fillable = ['montant', 'dr_id', 'type', 'reste'];
    public function droit(){
        return $this->belongsTo(Studentdroits::class, 'dr_id', 'id');
    }
}
