<?php

namespace App\Http\Controllers;
use App\Models\PatientModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
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

    public function logina(Request $request){
        $request->validate([
            'email' =>'required|email',
            'password' =>'required'
        ]);

        $patient = PatientModel::where('email', '=', $request->email)->first();
        if ($patient) {
            $hashedpword = md5($request->password); 
            if ($hashedpword === $patient->password) {
                $request->session()->put('LoginId', $patient->pa_id);
                return redirect('/log2');
            } else {
                return back()->with('fail', 'This incorrect password');
            }
        } else {
            return back()->with('fail', 'This email is not registered.');
        }
    }

    public function das2(){
        $data = null;
        if (Session::has('LoginId')){
            $data = PatientModel::where('pa_id', '=', Session::get('LoginId'))->first();
        }
        return view('das2', compact('data'));
    }

    public function logout(){
        if (Session::has('LoginId')){
            Session::pull('LoginId');
            return redirect('/login');
        }
    }

    public function index(){
        return view('dashboard');
    }

    public function paform(){
        return view('patient.form');
    }

    public function paregister(Request $request){
        $request->validate([
            'fname' => 'required',
            'lname' => 'required',
            'address' => 'required',
            'city' => 'required',
            'pnm' => 'required',
            'gender' => 'required',
            'age' => 'required',
            'email' => 'required',
            'password' => 'required|confirmed',
            'password_confirmation' => 'required',
            'img1' => 'nullable|mimes:png,jpeg,jpg,webp',
        ]);
    }

    public function pastore(Request $request){
        $patient = new PatientModel;
        $patient->fname = $request['fname'];
        $patient->lname = $request['lname'];
        $patient->address = $request['address'];
        $patient->city = $request['city'];
        $patient->pnm = $request['pnm'];
        $patient->gender = $request['gender'];
        $patient->age = $request['age'];
        $patient->email = $request['email'];
        $patient->password = md5($request['password']);
        $patient->role = $request['role'];
        $patient->save();
        return redirect('/patient/view');
    }

    public function paview(){
        $patient = PatientModel::all();
        $data = compact('patient');
        return view('patient.patient-view')->with($data);
    }

    public function padelete($id){
        $patient = PatientModel::where('pa_id', $id)->first();
        if (!is_null($patient)){
            if(File::exists($patient->img1)){
                File::delete($patient->img1);
            } 
            PatientModel::where('pa_id', $id)->delete();
        }
        return redirect('/patient/view');
    }

    public function paedit($id){
        $patient = PatientModel::where('pa_id', $id)->first();
        $dpt = DepartmentModel::all();
        if (is_null($patient)){
            return redirect('/patient/view');
        } else {
            $title = "Update Patient";
            $url = url('/patient/update/') . "/" . $id;
            $data = compact('patient', 'url', 'title', 'dpt');
            return view('patient.paupdate')->with($data);
        }
    }

    public function paupdate(Request $request, $id){
        $patient = PatientModel::find($id);
        if ($patient) {
            Log::info('Patient found: ' . $patient->pa_id);
            $patient->fname = $request['fname']; 
            $patient->lname = $request['lname'];
            $patient->address = $request['address'];
            $patient->city = $request['city'];
            $patient->pnm = $request['pnm'];
            $patient->gender = $request['gender'];
            $patient->weight = $request['weight'];
            $patient->age = $request['age'];
            $patient->email = $request['description'];
            $patient->mh = $request['mh'];
            $patient->dpt_id = $request['dt-id'];
            $patient->password = md5($request['password']);
            $patient->status = $request['status'];
            $patient->save();
            return redirect('/patient/view')->with('success', 'Patient updated successfully');
        } else {
            Log::info('Patient not found: ' . $id);
            return redirect('/patient/view')->with('error', 'Patient not found');
        }
    }

    public function changePassword(Request $request) {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:6|confirmed',
            'new_password_confirmation' => 'required',
        ]);

        $patientId = Session::get('LoginId');
        if (!$patientId) {
            return response()->json(['error' => 'You are not logged in.'], 401);
        }

        $patient = PatientModel::find($patientId);
        if (!$patient) {
            return response()->json(['error' => 'Patient not found.'], 404);
        }

        if (Hash::check($request->current_password, $patient->password)) {
            $patient->password = Hash::make($request->new_password);
            $patient->save();
            return response()->json(['message' => 'Password changed successfully'], 200);
        } else {
            return response()->json(['error' => 'Current password does not match'], 400);
        }
    }


}
