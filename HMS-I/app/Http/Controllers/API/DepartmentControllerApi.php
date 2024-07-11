<?php

namespace App\Http\Controllers\API;
use App\Models\DepartmentModel;
use App\Models\DoctorModel;
use App\Http\Controllers\Controller;
use App\Http\Middleware\Doctor;
use Illuminate\Http\Request;

class DepartmentControllerApi extends Controller
{
 public  function view(){
    $dpt =  DepartmentModel::all();
    
   $result = array('status'=> true, 'Data'=>$dpt);
   $rescode =200;
    return response()->json($result,$rescode);
 }
public function search(Request $request){
   $dpt =  DepartmentModel::with('doctor')->where('dpt_id',$request)->get();
   //$dpt = DoctorModel::where('dpt_id',$request)->get();
   $dc = $dpt->doctor->fname;
   $result = array('status'=> true, 'Data'=>$dc);
   $rescode =200;
    return response()->json($result,$rescode);

  }

}
