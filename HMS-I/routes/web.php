<?php
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DocController;
use App\Http\Controllers\PatientController;

use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\AppointmentController;
use Illuminate\Support\Facades\Route;




//prefixc
route::get('/login',[PatientController::class,'login'])->name('login');
route::post('/login',[PatientController::class,'logina'])->name('logina');
route::get('/log2',[PatientController::class,'das2'])->name('das2');
route::get('/logout',[PatientController::class,'logout'])->name('logout');
route::get('/', [AuthController::class,'index'])->name('pa.home');


route::get('/authcret',[AuthController::class,'authcrt'])->name('authcreate');
route::post('/authcret',[AuthController::class,'authcrta'])->name('authcreatea');
route::get('/auth',[AuthController::class,'authlogin'])->name('authlogin');
route::post('/auth',[AuthController::class,'authlogina'])->name('authlogina');
route::post('/logout',[AuthController::class,'logout'])->name('logout');

Route::group(['middleware'=> ['Adminmd']], function () {});


route::get('/schedule',[AppointmentController::class,'index'])->name('sc');
route::get('/sc-search',[AppointmentController::class,'search'])->name('sc.search');
route::get('/sc-search2',[AppointmentController::class,'search2'])->name('sc.search2');
route::get('/sc-see',[AppointmentController::class,'see'])->name('sc.see');
//route::get('/sc-form',[AppointmentController::class,'form'])->name('sc.form');
route::post('/sc-save',[AppointmentController::class,'save'])->name('sc.save');
route::post('/sc-check',[AppointmentController::class,'check'])->name('sc.check');//doc schedule check garni
route::get('/sc-view',[AppointmentController::class,'view'])->name('sc.view');//for doctor
route::get('/sc-see2/{id}',[AppointmentController::class,'see2'])->name('sc.see2');
route::post('/sc-see2up/{id}',[AppointmentController::class,'see2up'])->name('sc.seeup'); //patient problem update for doctor
route::get('/sc-status/{id}',[AppointmentController::class,'status'])->name('sc.status');

    
route::get('/department',[DepartmentController::class,'index'])->name('dt.add');
route::post('/dptregister',[DepartmentController::class,'dptstore'])->name('dt.save');
route::get('/dpt/view',[DepartmentController::class,'dtview'])->name('dt.view');
route::get('/dpt/edit/{id}',[DepartmentController::class,'dtedit'])->name('dt.edit'); 
route::get('/dpt/delete/{id}',[DepartmentController::class,'dtdelete'])->name('dt.delete'); 
route::post('/dpt/update/{id}',[DepartmentController::class,'dtupdate'])->name('dt.update'); 


Route::group(['middleware'=> ['Patientmd']], function () {
route::get('/patientdash',[PatientController::class,'padash'])->name('pa.dash');
route::get('/patient',[PatientController::class,'paform'])->name('pa.add');
route::post('/paregister',[PatientController::class,'pastore'])->name('pa.save');
route::post('/patient', [PatientController::class,'pastore']);
route::get('/patient/view', [PatientController::class,'paview'])->name('pa.view');
route::get('/patient/edit/{id}',[PatientController::class,'paedit'])->name('pa.edit'); 
route::post('/patient/update/{id}',[PatientController::class,'paupdate'])->name('pa.update'); 
route::get('/patient/delete/{id}',[PatientController::class,'padelete'])->name('pa.delete'); 
});
route::get('/doctordash',[DocController::class,'dcdash'])->name('dc.dash');
route::get('/doctor',[DocController::class,'dcform'])->name('dc.add');
route::post('/dcregister',[DocController::class,'dstore'])->name('dc.save');
route::post('/dcdoctor', [DocController::class,'dstore']);
route::get('/doctor/view', [DocController::class,'dview'])->name('dc.view');
route::get('/doctor/edit/{id}',[DocController::class,'dedit'])->name('dc.edit'); 
route::post('/doctor/update/{id}',[DocController::class,'dupdate'])->name('dc.update'); 
route::get('/doctor/delete/{id}',[DocController::class,'ddelete'])->name('dc.delete'); 



Route::group(['middleware' => ['Doctormd']],function () {
    
route::get('/doctordash',[DocController::class,'dcdash'])->name('dc.dash');
route::get('/doctor',[DocController::class,'dcform'])->name('dc.add');
route::post('/dcregister',[DocController::class,'dstore'])->name('dc.save');
route::post('/dcdoctor', [DocController::class,'dstore']);
route::get('/doctor/view', [DocController::class,'dview'])->name('dc.view');
route::get('/doctor/edit/{id}',[DocController::class,'dedit'])->name('dc.edit'); 
route::post('/doctor/update/{id}',[DocController::class,'dupdate'])->name('dc.update'); 
route::get('/doctor/delete/{id}',[DocController::class,'ddelete'])->name('dc.delete'); 
route::get('/doctor/profile/{id}',[DocController::class,'profile'])->name('dc.profile'); 

route::get('/schedule',[AppointmentController::class,'index'])->name('sc');
route::get('/sc-search',[AppointmentController::class,'search'])->name('sc.search');
route::get('/sc-see',[AppointmentController::class,'see'])->name('sc.see');
//route::get('/sc-form',[AppointmentController::class,'form'])->name('sc.form');
route::post('/sc-save',[AppointmentController::class,'save'])->name('sc.save');
route::post('/sc-check',[AppointmentController::class,'check'])->name('sc.check');//doc schedule check garni
route::get('/sc-view',[AppointmentController::class,'view'])->name('sc.view');//for doctor
route::post('/sc-save',[AppointmentController::class,'save'])->name('sc.save');
route::get('/sc-see2/{id}',[AppointmentController::class,'see2'])->name('sc.see2');
route::post('/sc-see2up/{id}',[AppointmentController::class,'see2up'])->name('sc.seeup'); //patient problem update for doctor
route::get('/sc-status/{id}',[AppointmentController::class,'status'])->name('sc.status');
route::get('/sc-paview/{id}',[AppointmentController::class,'allpa'])->name('sc.paview'); //all patients
route::get('/sc-patable',[AppointmentController::class,'paall'])->name('sc.patable'); //all patients
route::post('/filter',[DocController::class,'filter'])->name('filter');
});
 

    
route::get('/department',[DepartmentController::class,'index'])->name('dt.add');
route::post('/dptregister',[DepartmentController::class,'dptstore'])->name('dt.save');
route::get('/dpt/view',[DepartmentController::class,'dtview'])->name('dt.view');
route::get('/dpt/edit/{id}',[DepartmentController::class,'dtedit'])->name('dt.edit'); 
route::get('/dpt/delete/{id}',[DepartmentController::class,'dtdelete'])->name('dt.delete'); 
route::post('/dpt/update/{id}',[DepartmentController::class,'dtupdate'])->name('dt.update'); 




//Route::group(['middleware' => ['Nurse']], function () {});
    

// route::get('/nurse',[NurseController::class,'nform'])->name('nr.add');
// route::post('/register',[NurseController::class,'nstore'])->name('nr.save');
// route::post('/nurse', [NurseController::class,'nstore']);
// route::get('/nurse/view', [NurseController::class,'nview'])->name('nr.view');
// route::get('/nurse/edit/{id}',[NurseController::class,'nedit'])->name('nr.edit'); 
// route::post('/nurse/update/{id}',[NurseController::class,'nupdate'])->name('nr.update'); 
// route::get('/nurse/delete/{id}',[NurseController::class,'ndelete'])->name('nr.delete');


route::get('/ddash',[DepartmentController::class,'admin'])->name('dashm');
route::get('/table',[DepartmentController::class,'table']);
route::get('/test',[DepartmentController::class,'view']);
