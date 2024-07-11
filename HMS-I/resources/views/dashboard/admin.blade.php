
<!DOCTYPE html>
<html lang="en">
  <head>


<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="./assets/img/favicon.png">
@php
$fname=session()->get('fname');

@endphp
<title>
  Dashboard 
</title>



<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />

<!-- Nucleo Icons -->
<link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="./assets/css/nucleo-svg.css" rel="stylesheet" />

<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>

<!-- Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">

<!-- CSS Files -->



<link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.1.0" rel="stylesheet" />





<!-- Nepcha Analytics (nepcha.com) -->
<!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
<script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>


  </head>


  <body class="g-sidenav-show  bg-gray-100">
     <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark" id="sidenav-main">

  <div class="sidenav-header">
    <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
    <a class="navbar-brand m-0" href=" " target="_blank">
     
      <span class="ms-1 font-weight-bold text-white">Admin Dashboard </span>
    </a>
  </div>


  <hr class="horizontal light mt-0 mb-2">

  <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
    <ul class="navbar-nav">
      

<li class="nav-item">
  <a class="nav-link text-white " href="">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Dashboard</span>
  </a>
</li>

  
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('dc.view')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Doctor</span>
  </a>
</li>

  
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('pa.view')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Patient</span>
  </a>
</li>

  
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('dt.view')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Department</span>
  </a>
</li>
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('dt.add')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Create Department</span>
  </a>
</li>

  
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('sc.see')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Schedule</span>
  </a>
</li>

  


  
    <li class="nav-item mt-3">
      <h6 class="ps-4 ms-2 text-uppercase text-xs text-white font-weight-bolder opacity-8">Account </h6>
    </li>
  
<li class="nav-item">
  <a class="nav-link text-white " href="./profile.html">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10">person</i>
      </div>
    
    <span class="nav-link-text ms-1">Profile</span>
  </a>
</li>

  
<li class="nav-item">
  <a class="nav-link text-white " href="{{route('authcreate')}}">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10"></i>
      </div>
    
    <span class="nav-link-text ms-1">Create Account</span>
  </a>
</li>

  
<li class="nav-item"> 
  <a class="nav-link text-white " href="./sign-up.html">
    
      <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
        <i class="material-icons opacity-10">assignment</i>
      </div>
    
    <span class="nav-link-text ms-1">Sign Out</span>
  </a>
</li>



          

        
      
    </ul>
  </div>
  

  
</aside>

      <main class="main-content border-radius-lg ">
        <!-- Navbar -->

<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
  <div class="container-fluid py-1 px-3">
    <nav aria-label="breadcrumb">
      
      <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
        <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href=""></a></li>
       
      </ol>
      <h6 class="font-weight-bolder mb-0"></h6>
      
    </nav>
    <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
      <div class="ms-md-auto pe-md-3 d-flex align-items-center">
          
          <div class="input-group input-group-outline">
            <label class="form-label"></label>
            
          </div>
          
      </div>
        <li class="nav-item d-flex align-items-center">
          <a href="./pages/sign-in.html" class="nav-link text-body font-weight-bold px-0">
            <i class="fa fa-user me-sm-1"></i>
            
            <span class="d-sm-inline d-none">Sign Out</span>
            
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- End Navbar -->


        


            <div class="container-fluid py-4">
                


<div class="row">
  <div class="col-lg-7 position-relative z-index-2">
    <div class="card card-plain mb-4">
      <div class="card-body p-3">
        <div class="row">
          <div class="col-lg-6">
            <div class="d-flex flex-column h-100">
  <h2 class="font-weight-bolder mb-0">Welcome {{$fname}}</h2> 
  <!-- username rakhni  -->
</div>

          </div>
        </div>
      </div>
    </div>

  

      </div>
    </div>
  </div>
</div>

  <footer class="footer py-4  ">
  <div class="container-fluid">
    <div class="row align-items-center justify-content-lg-between">
      <div class="col-lg-6 mb-lg-0 mb-4">
        <div class="copyright text-center text-sm text-muted text-lg-start">
          © <script>
            document.write(new Date().getFullYear())
          </script>,
          made  by
          <p>LGIC group for Project</p>
         
        </div>
      </div>
      <div class="col-lg-6">
        <ul class="nav nav-footer justify-content-center justify-content-lg-end">
        
          <li class="nav-item">
            <a href="" class="nav-link text-muted" target="_blank">To fill</a>
          </li>
          <li class="nav-item">
            <a href="" class="nav-link text-muted" target="_blank">Tofill</a>
          </li>
          <li class="nav-item">
            <a href="" class="nav-link pe-0 text-muted" target="_blank">To fill</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</footer>
</main>
            </div>

      
    </div>
</div>

<script src="./assets/js/material-dashboard.min.js?v=3.1.0"></script>
  </body>

</html>
