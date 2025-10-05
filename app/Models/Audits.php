<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Audits extends Model
{
    protected $fillable = [
        'type',
        'details',
        'user_id',
    ];


    public function user(){
        return $this->belongsTo(User::class);
    }

    public function scopeTypes($query, $type){
        if($type == 'Tout'){
            return $query;
        }else{
            return $query->where('type', $type);
        }

    }
}

