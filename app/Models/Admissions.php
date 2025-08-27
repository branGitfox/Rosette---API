<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Admissions extends Model
{
    protected $fillable = [
        'note',
        'ac_id'
    ];

    public function acs() {
        return $this->belongsTo(Acs::class, 'ac_id', 'id');
    }
}
