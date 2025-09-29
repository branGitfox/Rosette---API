<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Workers extends Model
{
    protected $fillable = [
        'nom',
        'prenom',
        'email',
        'sexe',
        'adresse',
        'salaire_base',
        'p_id',
        'ac_id',
        'status',
        'telephone',
        'photo',
    ];

    public function profs(){
        return $this->belongsTo(Professions::class, 'p_id', 'id');
    }

    public function matiere(){
        return $this->HasMany(Matieres::class, 'w_id', 'id');
    }

    public function scopeIsProf($query){
        return $query->where('p_id', 1);
    }


}
