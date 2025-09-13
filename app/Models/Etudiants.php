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
        'ac_id'
    ];

    public function sousetudiants() {
        return $this->hasMany(Sousetudiants::class, 'et_id', 'id');
    }

    public function scopeSexe($query, $sexe){
        if($sexe == '0'){
            return $query;
        }else{
            return $query->where('sexe', $sexe=='Homme'?1:0);
        }

    }

    public function scopeYear($query, $annee){
        if($annee == 0){
            return $query;
        }else{
            return $query->Where('ac_id', $annee);
        }

    }

    public function scopeClasse($query, $classe){
        if($classe == 0){
            return $query;
        }else{
            return $query->whereHas('sousetudiants', function($q) use ($classe){
                $q->where('cl_id', $classe);
            });
        }
    }


    public function scopeSalle($query, $salle){
        if($salle == 0){
            return $query;
        }else{
            return $query->whereHas('sousetudiants', function($q) use ($salle){
                $q->where('sa_id', $salle);
            });
        }
    }



}
