<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReviewModel extends Model
{
    use HasFactory;
    protected $table = 'review';
    protected $primaryKey = 're_id';
    protected $fillable = [
      'redes',
      'fredes',
       
    ];
    public function doctor() {
        return $this->belongsTo(DoctorModel::class, 'dc_id');
    }
  
    public function patient() {
        return $this->belongsTo(PatientModel::class, 'pa_id');
    }
}
