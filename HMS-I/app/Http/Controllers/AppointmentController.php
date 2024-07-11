<?php

namespace App\Http\Controllers;
use App\Models\PatientModel;
use App\Models\AppointmentModel;
use App\Models\DoctorModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Session;
class AppointmentController extends Controller
{
    public function index(){
        return view ('appointment.index');
    }
    public function form()
    {
      return view ('appointment.scform');
    }


    public function search(){ //doc id bata garni banauni
    //this done
  $userId = Auth::user()->id;
   $patient = PatientModel::where('id', $userId)->first();
   session(['pid' => $patient->pa_id]);
   //Log::error('Patient record not found for user ID: ' . $userId);

  
        $doctor = DoctorModel::all();
        $starttime = DoctorModel::where('dc_id', 1)->value('starttime');//yo check garni
        $endtime = DoctorModel::where('dc_id', 1)->value('endtime');
        $data = compact('doctor', 'starttime', 'endtime');
     
       return view('appointment.scform')->with( $data);
    }
    public function search2(Request $request){ //doc id bata garni banauni
        //this done
    //    $userId = Auth::user()->id;
    //    $patient = PatientModel::where('id', $userId)->first();
       //session(['pid' => $patient->pa_id]);
       //Log::error('Patient record not found for user ID: ' . $userId);
       $id = $request->input('pa_id');
       $patient = PatientModel::where($id)->first();
      
            $doctor = DoctorModel::all();
            $starttime = DoctorModel::where('dc_id', 1)->value('starttime');//yo check garni
            $endtime = DoctorModel::where('dc_id', 1)->value('endtime');
            $data = compact('doctor', 'starttime', 'endtime');
         
           return view('appointment.scform')->with( $data);
        }
    


public function check(Request $request)
{
    $doctorId = $request->input('dc_id');
    $date = $request->input('apt-date'); 
    $formattedDate = date('Y-m-d', strtotime($date));
 

    $bookedSlots = AppointmentModel::where('dc_id', $doctorId)
        ->whereDate('aptdate', $formattedDate)
        ->pluck('apttime')
        ->toArray();

    // Assuming starttime and endtime are in the same model or related model
    $doctor = DoctorModel::find($doctorId);
    $starttime = $doctor->starttime;
    $endtime = $doctor->endtime;

    return response()->json([
        'bookedSlots' => $bookedSlots,
        'starttime' => $starttime,
        'endtime' => $endtime,
    ]);

}



 public function save(Request $request){
    $appt = new AppointmentModel;
    $appt->aptdate =$request['apt_date'];
    $appt->apttime =$request['apt_time'];
    $appt->dc_id =$request['dc_id'];
    $appt->pa_id =$request['pa_id'];
    $appt->pst =$request['pst'];
    $appt->save();
    return ('successfull');
 }
 public function view(){
     $id = session()->get('sid');
     Log::info($id);
    //$appt = AppointmentModel::where('dc_id', $id)->get();
    $apt = AppointmentModel::with(['doctor', 'patient'])->where('dc_id', $id)->where('status', '0')->get();
   // $appt = AppointmentModel::with(['doctor', 'patient'])->get();
   return view('appointment.appt-view', compact('apt'));
 }

 public function see(){
    $apt = AppointmentModel::with(['doctor', 'patient'])->get();
    $data= compact('apt');
    return view('appointment.index', $data);
 }
 public function see2(Request $request,$id){
    $apt = AppointmentModel::with(['doctor', 'patient'])->where('apt_id', $id)->first();
    // $apt = AppointmentModel::with(['doctor', 'patient'])->get();
    $data= compact('apt');

    return view('appointment.doc-edit', $data);
 }

 public function see2up(Request $request,$id){
    $did = session()->get('sid');
    $appointment = AppointmentModel::find($id);

    
    // $appointment->aptdate = $request->apt_date;
    // $appointment->apttime = $request->apt_time;
    $appointment->treat = $request->treat;
    $appointment->pres = $request->pres;

   
    $appointment->save();

    $apt = AppointmentModel::with(['doctor', 'patient'])->where('dc_id', $id)->where('status', '0')->get();
    // $apt = AppointmentModel::with(['doctor', 'patient'])->get();
   $data= compact('apt');

   return redirect()->route('sc.view')->with($data);
    //return view('appointment.appt-view', compact('apt'));
 }
 public function delete($id){
    $apt = AppointmentModel::find($id);
    $apt->delete();
    return redirect()->route('sc.view');
 }
 public function status($id){
    $did = session()->get('sid');
    $apt = AppointmentModel::with(['doctor', 'patient'])->where('dc_id', $did)->where('status', '0')->get();
    $data= compact('apt');

    $apt = AppointmentModel::find($id);
    $apt->status = 1;
    $apt->save();
    return redirect()->route('sc.view')->with($data);

 }
 public function allpa($id){
    $did = session()->get('sid');
    $apt = AppointmentModel::with(['doctor', 'patient'])->where('dc_id', $did)->first();
    $data= compact('apt');
    return view('appointment.doc-paview')->with($data);
 }
 public function paall(){
    $did = session()->get('sid');
    $apt = AppointmentModel::with(['doctor', 'patient'])->where('dc_id', $did)->get();
    $data= compact('apt');
    return view('appointment.doc-patable')->with($data);
 }

}
