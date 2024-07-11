<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdminModel extends Model
{
    use HasFactory;
    protected $table = 'adminacc';
    protected $primaryKey = 'a_id';
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
         'role',
        
    ];
    public function user()
    {
        return $this->belongsTo(User::class,'id');
    }
}
