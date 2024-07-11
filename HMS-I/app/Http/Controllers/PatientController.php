<?php

namespace App\Http\Controllers;
use App\Models\PatientModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\md5;
use Illuminate\Support\Facades\Hash;
use Resourses\Views\hm;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Session;
use App\Models\DepartmentModel;
class PatientController extends Controller
{ 
    public function padash(){
        return view('patient.pa-dash');
    }
    public function login(){
        return view('loginform');
    }
    public function logina( Request $request){
        //return('logged in');
        $request->validate([
            'email' =>'required|email',
            'password' =>'required'
        ]);
          
       //echo $request->email;
      
       //echo $request->password;
        $patient =  PatientModel::where('email', '=', $request->email)->first();
          if ($patient){
             $hashedpword= md5($request->password); 
               if($hashedpword === $patient->password){
                $request->session()->put('LoginId', $patient->pa_id);
                return redirect ('/log2');
         
               }
               else{
                   return  back()->with('fail','This incorrect password');
               }
           }
           else {
               return  back()->with('fail','This email is not registered.');
          }
    }
    public function das2(){
        //logged in dashboard
        //$data=array();
        $data = null;
        if (Session::has('LoginId')){
            $data  = PatientModel::where('pa_id' ,'=',Session::get('LoginId'))->first();
        }
       
        return view ('das2',compact('data'));
        // $tata =compact('data');
        // return view ('das2')->with($tata);
    }
    public function logout(){
        if (Session::has('LoginId')){
            session::pull('LoginId');
            return redirect ('/login');
        }
    }

    public function index(){
        return view('dashboard');
    }
    public function paform(){
        //create
        // $url = url('/register');
        // $patient = new PatientModel();
        // $title=" Patient registration";
        // $data = compact('url','title','patient');
        // return view('patient.form')->with( $data);
        return view('patient.form');
    }
    public function paregister(Request $request){
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
    public function pastore(Request $request){
        // echo"<pre>";
        // print_r($request->all());   
        $patient = new PatientModel; 
        // if($request->has('img1')){

        //     $file = $request->file('img1');
        //     $extn= $file->getClientOriginalExtension();
        //     $filename = time().'PA.'.$extn;
        //     $path ='upload/pacimg/';
        //     $file->move($path,$filename);
        // } 
        
        $patient->fname =$request['fname'];
        $patient->lname =$request['lname'];
        $patient->address =$request['address'];
        $patient->city =$request['city'];
        $patient->pnm =$request['pnm'];
        $patient->gender =$request['gender'];
        $patient->age =$request['age'];
        $patient->email =$request['email'];
        $patient->password =md5($request['password']);
       // $patient->img1=$path.$filename;
        $patient->role =$request['role'];
        $patient->save();
        return redirect('/patient/view');


    }
    public function paview(){
        $patient =  PatientModel::all();
        
        $data = compact('patient');
        return view ('patient.patient-view')->with($data);
         
    }
public function padelete($id)
{
    // Fetch the patient record(s) based on the provided ID
    $patient = PatientModel::where('pa_id', $id)->first();
    if (!is_null($patient)){
        if(File::exists($patient->img1)){
            File::delete($patient->img1);
        } 
        $patient = PatientModel::where('pa_id', $id)->delete();
    }

    return redirect('/patient/view');

    
    // Check if any records are found
    // if ($patient->isEmpty()) {
    //     // Handle case when no records are found
    //     echo "No patient found with the provided ID.";
    // } else {
    //     $patient = Patientacc::where('pa_id', $id)->delete();
       
    // }
}

public function paedit($id){
    //$patient=Patientacc::find($id);
     $patient = PatientModel::where('pa_id', $id)->first();
    $dpt =  DepartmentModel::all();
    
    if (is_null($patient)){
        return redirect('/patient/view');
        // $patient = Patientacc::where('pa_id', $id)->delete();
    }
    else{
        $title="Update  Patient ";
        $url=url('/patient/update/')."/".$id;
        $data = compact('patient','url','title','dpt');
       return view('patient.paupdate')->with( $data);
        
    } }
    // public function dtview2(){
    //     $dpt =  DepartmentModel::all();
        
    //     $data = compact('dpt');
    //     return view ('patient.paupdate')->with($data);
       
         
    // }
 
public function paupdate(Request $request , $id){
    //$patient = Patientacc::where('pa_id', $id)->first();
   //dd($patient);
   $patient = PatientModel::find($id);
//    if($request->has('img1')){

//     $file = $request->file('img1');
//     $extn= $file->getClientOriginalExtension();
//     $filename = time().'PA.'.$extn;
//     $path ='upload/pacimg/';
//     $file->move($path,$filename);
//     if(File::exists($patient->img1)){
//         File::delete($patient->img1);
//     }
//}
   if($patient){
    Log::info('Patient found: ' . $patient->pa_id);
    $patient->fname =$request['fname']; 
    $patient->lname =$request['lname'];
    $patient->address =$request['address'];
    $patient->city =$request['city'];
    $patient->pnm =$request['pnm'];
    $patient->gender =$request['gender'];
    $patient->weight =$request['weight'];
    $patient->age =$request['age'];
    $patient->email =$request['description'];
    $patient->mh =$request['mh'];
    $patient->dpt_id =$request['dt-id'];
   // $patient->img1=$path.$filename;
    $patient->password =md5($request['password']);
    $patient->status =$request['status'];
    $patient->save();
    
   // return redirect('/patient/view');
   return redirect('/patient/view')->with('success', 'Patient updated successfully');
    } else {
        Log::info('Patient not found: ' . $id);
        return redirect('/patient/view')->with('error', 'Patient not found');
    }

}
}
