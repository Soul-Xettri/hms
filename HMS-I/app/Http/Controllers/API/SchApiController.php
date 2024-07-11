<?php

namespace App\Http\Controllers\API;
use App\Models\AppointmentModel;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SchApiController extends Controller
{
    public function scview(){
       // $appt = AppointmentModel::all();
        $appt = AppointmentModel::with(['doctor', 'patient'])->get();
        $result  = array('status' =>true, 'message'=>"Scheduled patients=".count($appt),"data"=>$appt );
        $rescode =200; 
        return response()->json($result,$rescode);
      
     }
   
}
