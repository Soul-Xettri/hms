<app-layout>
    <slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </slot>
    <nav class="navbar navbar-default navbar-">
    <!-- @if(session()->has('name'))
        {{session()->get('name')}}
    @else
    Guest
    @endif -->
  
    <div ><a href="{{route('login')}}">
        <button class="btn btn-primary"> Login</button>
        </a></div>
       
    <div ><a href="{{route('pa.add')}}">
        <button class="btn btn-primary"> Add patients</button>
        </a></div>
    <div >
        <a href="{{route('pa.view')}}">
        <button class="btn btn-primary"> patients</button>
        </a>
    </div> 
    
    <div ><a href="{{route('dc.add')}}">
        <button class="btn btn-primary"> Add Doctor</button>
        </a></div>
    <div >
        <a href="{{route('dc.view')}}">
        <button class="btn btn-primary">View Doc</button>
        </a>
    </div> 
    <div >
        <a href="{{route('nr.add')}}">
        <button class="btn btn-primary">Add Nurse</button>
        </a>
    </div> 
    <div >
        <a href="{{route('nr.view')}}">
        <button class="btn btn-primary">View Nurse</button>
        </a>
    </div> 
    <div > 
        <a href="{{route('sc')}}">
        <button class="btn btn-primary">Schedule</button>
        </a>
    </div>
</nav>
<body>
@php

    $sname = session()->get('fname');
   
@endphp
  
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                
                   <h1>Welcome Patient {{$sname }} </h1>
                </div>
            </div>
        </div>
        <a href="{{route('sc.search')}}" button class="btn btn-primary">Schedule apointment?</a>
    </div>
    </body>
</app-layout>

