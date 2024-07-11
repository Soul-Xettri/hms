<?php

namespace App\Http\Controllers\API;
use App\Models\NurseModel;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\md5;
use Illuminate\Support\Facades\Hash;
use Resourses\Views\hm;
use Illuminate\Support\Facades\Session;
use PHPUnit\Framework\Constraint\Count;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;


class NurseApiController extends Controller
{
    public function nrstore(Request $request){
        $nurse= new NurseModel; 
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
       
        $nurse->fname =$request['fname'];
        $nurse->lname =$request['lname'];
        $nurse->address =$request['address'];
        $nurse->city =$request['city'];
        $nurse->pnm =$request['pnm'];
        $nurse->gender =$request['gender'];
        $nurse->age =$request['age'];
        $nurse->email =$request['email'];
        $nurse->password =md5($request['password']);
        $nurse->role =$request['role'];
        $nurse->save();
        
        if($nurse->nr_id){
            $result = array('status' => true, 'message' =>"Successfully created", "data" =>$nurse);
            $rescode =200;
        }
        else{
            $result = array('status' => false, 'message' =>"Something went wrong");
            $rescode =400;
        }

        return response()->json($result,$rescode);
}
public function nrview(){
   
    $nurse =  NurseModel::all();
    
    $result = array('status' => true, 'message' =>Count($nurse)."User(s) fetched", "data" =>$nurse);
    $rescode =200;
    return response()->json($result,$rescode);
}
public function nrviewed($id){
    $nurse =  NurseModel::find($id);
    if(!$nurse){
        return response()->json(['status' => false, 'message' =>"User not found",404]);
    }
    $result = array('status' => true, 'message' =>"Your data", "data" => $nurse);
    $rescode =200;
    return response()->json($result,$rescode);
}



}
