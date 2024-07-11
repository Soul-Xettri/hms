<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PatientModel;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class PatientApiController extends Controller
{
    public function index()
    {
        return view('dashboard');
    }

    public function pastore(Request $request)
    {
        $valid = Validator::make($request->all(), [
            'fname' => 'required',
            'lname' => 'required',
            'address' => 'required',
            'city' => 'required',
            'pnm' => 'required',
            'gender' => 'required',
            'age' => 'required',
            'email' => 'required|unique:patientacc',
            'password' => 'required|confirmed',
            'password_confirmation' => 'required',
        ]);

        if ($valid->fails()) {
            $result = [
                'status' => false,
                'message' => "Validation Wrong",
                'error_message' => $valid->errors()
            ];
            return response()->json($result, 400);
        }

        // Create a new User
        $user = new User;
        $user->fname = $request['fname'];
        $user->lname = $request['lname'];
        $user->email = $request['email'];
        $user->password = Hash::make($request['password']);
        $user->save();

        // Create a new PatientModel and set the user_id
        $patient = new PatientModel;
        $patient->fname = $request['fname'];
        $patient->lname = $request['lname'];
        $patient->address = $request['address'];
        $patient->city = $request['city'];
        $patient->pnm = $request['pnm'];
        $patient->gender = $request['gender'];
        $patient->age = $request['age'];
        $patient->email = $request['email'];
        $patient->password = Hash::make($request['password']);
        $patient->role = $request['role'];
        $patient->user_id = $user->id; // Set the user_id from the created user
        $patient->save();

        if ($patient->pa_id) {
            $result = [
                'status' => true,
                'message' => "Successfully created",
                'data' => $patient
            ];
            $rescode = 200;
        } else {
            $result = [
                'status' => false,
                'message' => "Something went wrong"
            ];
            $rescode = 400;
        }

        return response()->json($result, $rescode);
    }

    public function paview()
    {
        $patients = PatientModel::all();
        $result = [
            'status' => true,
            'message' => count($patients) . " User(s) fetched",
            'data' => $patients
        ];
        $rescode = 200;
        return response()->json($result, $rescode);
    }

    public function paviewed($id)
    {
        $patient = PatientModel::find($id);
        if (!$patient) {
            return response()->json(['status' => false, 'message' => "User not found"], 404);
        }
        $result = [
            'status' => true,
            'message' => "Your data",
            'data' => $patient
        ];
        $rescode = 200;
        return response()->json($result, $rescode);
    }

    public function paup($id)
    {
        $patient = PatientModel::find($id);
        if (!$patient) {
            return response()->json(['status' => false, 'message' => "User not found"], 404);
        }
        $url = route('pa.update.api', ['id' => $id]);
        return response()->json($patient, $url);
    }

    public function paupdate(Request $request, $id)
    {
        $patient = PatientModel::find($id);
        if (!$patient) {
            return response()->json(['status' => false, 'message' => "User not found"], 404);
        }

        $valid = Validator::make($request->all(), [
            'fname' => 'sometimes|required',
            'lname' => 'sometimes|required',
            'address' => 'sometimes|required',
            'city' => 'sometimes|required',
            'pnm' => 'sometimes|required',
            'gender' => 'sometimes|required',
            'age' => 'sometimes|required',
            'email' => 'sometimes|required|email|unique:patientacc,email,'.$id.',pa_id',
            'password' => 'sometimes|confirmed',
        ]);

        if ($valid->fails()) {
            $result = [
                'status' => false,
                'message' => "Validation Wrong",
                'error_message' => $valid->errors()
            ];
            return response()->json($result, 400);
        }

        if ($request->has('fname')) {
            $patient->fname = $request['fname'];
        }
        if ($request->has('lname')) {
            $patient->lname = $request['lname'];
        }
        if ($request->has('address')) {
            $patient->address = $request['address'];
        }
        if ($request->has('city')) {
            $patient->city = $request['city'];
        }
        if ($request->has('pnm')) {
            $patient->pnm = $request['pnm'];
        }
        if ($request->has('gender')) {
            $patient->gender = $request['gender'];
        }
        if ($request->has('weight')) {
            $patient->weight = $request['weight'];
        }
        if ($request->has('age')) {
            $patient->age = $request['age'];
        }
        if ($request->has('email')) {
            $patient->email = $request['email'];
        }
        if ($request->has('mh')) {
            $patient->mh = $request['mh'];
        }
        if ($request->has('password')) {
            $patient->password = Hash::make($request['password']);
        }
        if ($request->has('status')) {
            $patient->status = $request['status'];
        }
        
        $patient->save();

        $rescode = 200;
        return response()->json($patient, $rescode);
    }
}
