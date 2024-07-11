<?php
namespace App\Http\Controllers\API;
use App\Models\DoctorModel;
use App\Models\PatientModel;
use App\Models\AdminModel;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class UserApi extends Controller
{
    public function create(Request $request)
    {
        $crt = new User;
        $valid = Validator::make($request->all(), [
            'fname' => 'required',
            'lname' => 'required',
            'email' => 'required|unique:patientacc',
            'password' => 'required|confirmed',
            'password_confirmation' => 'required',
        ]);

        if ($valid->fails()) {
            $result = array('status' => false, 'message' => "Validation Wrong", 'error_message' => $valid->errors());
            return response()->json($result, 400);
        }

        $crt->fname = $request['fname'];
        $crt->lname = $request['lname'];
        $crt->email = $request['email'];
        $crt->password = Hash::make($request['password']);
        $crt->role = $request['role'];
        $crt->save();

        if ($request->role == 'Patient') {
            $patient = new PatientModel();
            $patient->user_id = $crt->id;
            $patient->fname = $crt->fname;
            $patient->lname = $crt->lname;
            $patient->email = $crt->email;
            $patient->password = $crt->password;
            $patient->role = 'Patient';
            $patient->save();
        } elseif ($request->role == 'Doctor') {
            $doctor = new DoctorModel();
            $doctor->user_id = $crt->id;
            $doctor->fname = $crt->fname;
            $doctor->lname = $crt->lname;
            $doctor->email = $crt->email;
            $doctor->password = $crt->password;
            $doctor->role = 'Doctor';
            $doctor->save();
        }

        if ($crt->id) {
            $result = array('status' => true, 'message' => "Successfully created", "data" => $patient);
            $rescode = 200;
        } else {
            $result = array('status' => false, 'message' => "Something went wrong");
            $rescode = 400;
        }

        return response()->json($result, $rescode);
    }

    public function login(Request $request)
    {
        $valid = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
        ]);

        if ($valid->fails()) {
            $result = array('status' => false, 'message' => "Validation Wrong", 'error_message' => $valid->errors());
            return response()->json($result, 400);
        }

        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            session(['fname' => Auth::user()->fname]);
            session(['sid' => Auth::user()->id]);
            Log::info('Session data after login:', session()->all());

            $user = User::find(auth()->user()->id);
            $userid = $user->id;
            $data = PatientModel::where('user_id', $userid)->first(); // Use user_id instead of id
            $result = array('status' => true, 'message' => "Your data", 'value' => $data);
            $rescode = 200;
            return response()->json($result, $rescode);
        } else {
            Log::info('Authentication failed for email: ' . $credentials['email']);
            return response()->json(['status' => false, 'message' => "User not found"], 404);
        }
    }

    public function redirect()
    {
        $redirect = '';
        if (Auth::check()) {
            $role = Auth::user()->role;
            Log::info('User role: ' . $role);
            switch (Auth::user()->role) {
                case 'Doctor':
                    $did = session('sid');
                    $user = User::find($did);
                    $dcid = $user->doctor->dc_id;
                    session(['sid' => $dcid]);
                    Log::info('before redirect', ['dc_id' => $dcid]);
                    $redirect = '/doctordash';
                    break;

                case 'Patient':
                    $did = session('sid');
                    $id = PatientModel::where('pa_id', $did)->first();
                    session(['sid' => $id->pa_id]);
                    Log::info('before redirect', [$id]);
                    $redirect = '/patientdash';
                    break;

                case 'Admin':
                    $did = session('sid');
                    $id = AdminModel::where('a_id', $did)->first();
                    session(['sid' => $id->a_id]);
                    Log::info('before redirect', [$id]);
                    $redirect = '/ddash';
                    break;
            }
            return $redirect;
        }
        return view('auth.failed');
    }
}
