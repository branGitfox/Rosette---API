<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Etudiants extends Model
{
    protected $fillable = [
        'nom',
        'prenom',
        'sexe',
        'dateNaissance',
        'lieuNaissance',
        'adresse',
        'nomPere',
        'nomMere',
        'telephonePere',
        'telephoneMere',
        'prenomMere',
        'prenomPere',
        'nomTuteur',
        'prenomTuteur',
        'telephoneTuteur',
        'matricule',
        'ecole',
        'enfantProf',
        'photo',
    ];

    public function sousetudiants() {
        return $this->hasMany(Sousetudiants::class, 'et_id', 'id');
    }

}
