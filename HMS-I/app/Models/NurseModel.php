<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NurseModel extends Model
{
    use HasFactory;
    protected $table = 'nurseacc';
    protected $primaryKey = 'nr_id';
    protected $fillable = [
        'fname',
        'lname',
        'address',
        'city',
        'pnm',
        'gender',
        'age',
        'email',
        'password',
        'img1',
        'role',
        
    ];
}
