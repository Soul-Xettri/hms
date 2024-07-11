<?php

namespace App\Http\Controllers;
use App\Models\DepartmentModel;
use App\Models\DoctorModel;
use Illuminate\Http\Request;

class DepartmentController extends Controller
{
    public function index(){
        return view('department.dpt-form');
    }

    public function dptstore(Request $request){
         
        $dpt = new DepartmentModel; 
      
        
        $dpt->dpt_name =$request['dpt_name'];
        $dpt->dpt_des =$request['dpt_des'];
     
        $dpt->save();
        return redirect('/dpt/view');

    }
    public function dtview(){
        $dpt =  DepartmentModel::all();
        
        $data = compact('dpt');
        
        return view ('department.dpt-view')->with($data);
         
    }
    public function dtview2(){
        $dpt =  DepartmentModel::all();
        
        $data = compact('dpt');
        return view ('patient.paupdate')->with($data);
       
         
    }
    public function dtdelete($id){
        // $dpt = DepartmentModel::where('dpt_id', $id)->first();
        // $dpt = DepartmentModel::where('dpt_id', $id)->delete();
        DepartmentModel::where('dpt_id', $id)->delete();
    
        return redirect('/dpt/view');
    }
    public function dtedit($id){
        $dpt = DepartmentModel::where('dpt_id', $id)->first();
        if (is_null($dpt)){
            return redirect('/dt/view');
           
        }
        else{
            
            $url=url('/dt/update/')."/".$id;
            $data = compact('dpt','url');
            return view('department.dpt-update')->with( $data);
            
        } 
    }
    public function dtupdate(Request $request , $id){
       
       $dpt = DepartmentModel::find($id);
      
    
       
        $dpt->dpt_name =$request['dpt_name']; 
        $dpt->dpt_des =$request['dpt_des'];

        $dpt->save();
        return redirect('/dpt/view');
    
    }

    public function admin(){
        return view('dashboard.admin');
    }
    public function table(Request $request){
        $search = $request['search'] ?? "";
        if($search !=""){
            $doctor =  DoctorModel::where('fname','LIKE', "%$search%")->get();
        }
        else{
        $doctor =  DoctorModel::all();
        }
        $data = compact('doctor');
        return view('dashboard.table')->with( $data);
    }
    public function view(){
        return view('doctor.test');
    }
}
