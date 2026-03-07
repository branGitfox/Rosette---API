<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Studentdroits extends Model
{
    use HasFactory;

    protected $table = 'studentdroits';
    protected $fillable = ['se_id', 'reste', 'payed', 'paid'];

    public function histo(){
        return $this->hasMany(Droithistos::class, 'dr_id', 'id');
    }

}
