<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DoctorModel extends Model
{
    use HasFactory;
    
    protected $table = 'docacc';
    protected $primaryKey = 'dc_id';
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
        'dpt_id',
        'role',
        'speciality',
        'qual',
        'exp',
        'starttime',
        'endtime',  
        
    ];
    public function appointments() {
        return $this->hasMany(AppointmentModel::class, 'doctor_id');
    }
    public function review() {
        return $this->hasMany(ReviewModel::class, 'doctor_id');
    }
    public function user()
    {
        return $this->belongsTo(User::class,'id');
    }
    public function departmenttyp() {
        return $this->belongsTo(DepartmentModel::class, 'dpt_id');
    }

}
