<?php

namespace App\Http\Controllers\API;

use App\Models\DoctorModel;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\md5;
use Illuminate\Support\Facades\Hash;
use Resourses\Views\hm;
use Illuminate\Support\Facades\Session;
use PHPUnit\Framework\Constraint\Count;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DoctorApiController extends Controller
{
    public function dcstore(Request $request){
        $doctor = new DoctorModel; 
        $valid= Validator::make($request->all(),[
            'fname' => 'required',
            'lname' => 'required',
            'address' => 'required',
            'city' => 'required',
            'pnm' => 'required',
            'gender' => 'required',
            'age' => 'required',
            'email' => 'required|unique:docacc',
            'password' => 'required |confirmed',
            'password_confirmation' => 'required ',
        ]);
        if($valid->fails()) {   
            $result = array('status' => false, 'message' =>"Validation Wrong",
            'error_message' => $valid->errors());
            return response()->json($result,400);
        }
       
        $doctor->fname =$request['fname'];
        $doctor->lname =$request['lname'];
        $doctor->address =$request['address'];
        $doctor->city =$request['city'];
        $doctor->pnm =$request['pnm'];
        $doctor->gender =$request['gender'];
        $doctor->age =$request['age'];
        $doctor->email =$request['email'];
        $doctor->password =md5($request['password']);
      
        $doctor->role =$request['role'];
        $doctor->save();
        
        if($doctor->dc_id){
            $result = array('status' => true, 'message' =>"Successfully created", "data" =>$doctor);
            $rescode =200;
        }
        else{
            $result = array('status' => false, 'message' =>"Something went wrong");
            $rescode =400;
        }

        return response()->json($result,$rescode);
}
public function dcview(){
   
    $doctor =  DoctorModel::all();
    
    $result = array('status' => true, 'message' =>Count($doctor)."User(s) fetched", "data" =>$doctor);
    $rescode =200;
    return response()->json($result,$rescode);
}
public function dcviewed($id){
    $doctor =  DoctorModel::find($id);
    if(!$doctor){
        return response()->json(['status' => false, 'message' =>"User not found",404]);
    }
    $result = array('status' => true, 'message' =>"Your data", "data" => $doctor);
    $rescode =200;
    return response()->json($result,$rescode);
}

public function dcupdate(Request $request , $id){
     
    $doctor = DoctorModel::find($id);
 
    if(!$doctor){
     return response()->json(['status' => false, 'message' =>"User not found",404]);
 }
 // $valid= Validator::make($request->all(),[
 //     'fname' => 'required',
 //     'lname' => 'required',
 //     'address' => 'required',
 //     'city' => 'required',
 //     'pnm' => 'required|numeric',// |digits:10, createma pani 
 //     'gender' => 'required',
 //     'age' => 'required',
 //     'email' => 'required',
 //     'password' => 'required |confirmed',
 //     'password_confirmation' => 'required ',
 // ]);
 // if($valid->fails()) {   
 //     $result = array('status' => false, 'message' =>"Validation Wrong",
 //     'error_message' => $valid->errors());
 //     return response()->json($result,400);
 // }
     $doctor->fname =$request['fname']; 
     $doctor->lname =$request['lname'];
     $doctor->address =$request['address'];
     $doctor->city =$request['city'];
     $doctor->pnm =$request['pnm'];
     $doctor->gender =$request['gender'];
     $doctor->age =$request['age'];
     $doctor->email =$request['email'];
     $doctor->password =md5($request['password']);
    
     $doctor->save();
     
     $result = array('status' => true, 'message' =>"Successfully Updated", "data" =>$doctor);
     $rescode =200;
     return response()->json($result,$rescode);

 }



}