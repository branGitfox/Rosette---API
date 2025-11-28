<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rolespages extends Model
{
    use HasFactory;
    protected $table = 'roles_pages';
    protected $fillable = ['role_id', 'page_id'];
}
