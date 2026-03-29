<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Kermessehistos extends Model
{
    protected $fillable = ['montant', 'kr_id', 'type', 'reste'];
    public function kr(){
        return $this->belongsTo(Studentkermesses::class, 'kr_id', 'id');
    }
}
