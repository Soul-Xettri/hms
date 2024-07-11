<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppointmentModel extends Model
{
    use HasFactory;
    
    protected $table = 'appointment';
    protected $primaryKey = 'apt_id';
    protected $fillable = [
      'aptdate',
      'apttime',
      'pst',// problems
      'treat',
      'status',
        'pres', //medication
    ];
   
    
    public function doctor() {
      return $this->belongsTo(DoctorModel::class, 'dc_id');
  }

  public function patient() {
      return $this->belongsTo(PatientModel::class, 'pa_id');
  }
}
