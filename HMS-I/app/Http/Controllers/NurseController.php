<?php

namespace App\Http\Controllers;

use App\Models\NurseModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
class NurseController extends Controller
{
    public function index(){
        return view('dashboard');
    }
    public function nform(){
        //create
        // $url = url('/register');
        // $nurse = new NurseModel();
        // $title=" Nurse registration";
        // $data = compact('url','title','nurse');
        // return view('nurse.nrform')->with( $data);
        return view('nurse.nrform');
    }
    public function nregister(Request $request){
        $request->validate(
            [
        'fname' => 'required',
        'lname' => 'required',
        'address' => 'required',
        'city' => 'required',
        'pnm' => 'required',
        'gender' => 'required',
        'age' => 'required',
        'email' => 'required',
        'password' => 'required |confirmed',
        'password_confirmation' => 'required ',
        'img1' => 'nullable|mimes:png,jpeg,jpg,webp',
            ]);
        

    }
    public function nstore(Request $request){
        // echo"<pre>";
        // print_r($request->all());    
        $nurse  = new NurseModel;
        // if($request->has('img1')){

        //     $file = $request->file('img1');
        //     $extn= $file->getClientOriginalExtension();
        //     $filename = time().'NR.'.$extn;
        //     $path ='upload/pacimg/';
        //     $file->move($path,$filename);
        // }
        $nurse ->fname =$request['fname'];
        $nurse ->lname =$request['lname'];
        $nurse ->address =$request['address'];
        $nurse ->city =$request['city'];
        $nurse ->pnm =$request['pnm'];
        $nurse ->gender =$request['gender'];
        $nurse ->age =$request['age'];
        $nurse ->email =$request['email'];
        $nurse ->password =md5($request['password']);
        //$nurse->img1=$path.$filename;
        $nurse ->role =$request['role'];
        $nurse ->save();
        return redirect('/nurse/view');


    }
    public function nview(){
        $nurse  =  NurseModel::all();
        
        $data = compact('nurse');
        return view ('nurse.nr-view')->with($data);
         
    }
public function ndelete($id)
{
    // Fetch the patient record(s) based on the provided ID
    $nurse  = NurseModel::where('nr_id', $id)->first();
    if (!is_null($nurse )){
        if(File::exists($nurse->img1)){
            File::delete($nurse->img1);
        }
        $nurse = NurseModel::where('nr_id', $id)->delete();
    }

    return redirect('/nurse/view');

    
    // Check if any records are found
    // if ($patient->isEmpty()) {
    //     // Handle case when no records are found
    //     echo "No patient found with the provided ID.";
    // } else {
    //     $patient = Patientacc::where('pa_id', $id)->delete();
       
    // }
}

public function nedit($id){
    //$patient=Patientacc::find($id);
     $nurse  = NurseModel::where('nr_id', $id)->first();
    if (is_null($nurse )){
        return redirect('/nurse/view');
        // $patient = Patientacc::where('pa_id', $id)->delete();
    }
    else{
        $title="Update  Nurse";
        $url=url('/nurse/update/')."/".$id;
        $data = compact('nurse','url','title');
        return view('nurse.nrupdate')->with( $data);
    }

}
public function nupdate(Request $request , $id){
    
   $nurse  = NurseModel::find($id);
  
//    if($request->has('img1')){

//     $file = $request->file('img1');
//     $extn= $file->getClientOriginalExtension();
//     $filename = time().'NR.'.$extn;
//     $path ='upload/pacimg/';
//     $file->move($path,$filename);
//     if(File::exists($nurse->img1)){
//         File::delete($nurse->img1);
//     }
   
    $nurse ->fname =$request['fname'];
    $nurse ->lname =$request['lname'];
    $nurse ->address =$request['address'];
    $nurse ->city =$request['city'];
    $nurse ->pnm =$request['pnm'];
    $nurse ->gender =$request['gender'];
    $nurse ->age =$request['age'];
    $nurse ->email =$request['email'];
    $nurse ->password =md5($request['password']);
    //$nurse->img1=$path.$filename;
    
    $nurse ->save();
    return redirect('/nurse/view');

}
}
