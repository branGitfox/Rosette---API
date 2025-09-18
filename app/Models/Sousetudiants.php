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
        'note3',
        'noteTotal',
        'status_admissions',
    ];

    public function classe(){
        return $this->belongsTo(Classes::class, 'cl_id', 'id');
    }
    public function salle(){
        return $this->belongsTo(Salles::class, 'sa_id', 'id');
    }

    public function annee() {
            return $this->belongsTo(Acs::class, 'ac_id', 'id');
    }

    public function ecolage() {
        return $this->hasMany(Moisecolage::class, 'et_id', 'id');
    }


}
