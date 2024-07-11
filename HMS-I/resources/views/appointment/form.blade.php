 
<!DOCTYPE html>
<head><nav class="navbar navbar-default navbar-">
<nav class="navbar navbar-default navbar-">
    <!-- @if(session()->has('name'))
        {{session()->get('name')}}
    @else
    Guest
    @endif -->
    
    <div ><a href="{{route('pa.home')}}">
        <button class="btn btn-primary"> Home</button>
        </a></div>
    <div ><a href="{{route('pa.add')}}">
        <button class="btn btn-primary"> Add patients</button>
        </a></div>
    <div >
        <a href="{{route('pa.view')}}">
        <button class="btn btn-primary"> Patient View</button>
        </a>
    </div> 
    
    <div ><a href="{{route('dc.add')}}">
        <button class="btn btn-primary"> Add Doctor</button>
        </a></div>
    <div >
        <a href="{{route('dc.view')}}">
        <button class="btn btn-primary">view doc</button>
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
  
</nav>
</head>
<body>

    <form method="post" action="{{route('sc.save')}}" enctype="multipart/form-data">
        
    @csrf 
    <h1 >Schedule</h1>
     

    <div class="form-grop">
       
    <label for="apt">Date</label>
                <input id="" class="block mt-1 w-full" type="datetime-local" name="apt" value="" >
            </div>
            <div>
            <label> Select doctor</label>
                <select class="form-control" name="dc_id" >
                    @foreach ($doctor as $doc )
                    <option value="{{ $doc->dc_id}}">{{$doc->fname}}</option>
                    
                    @endforeach
                </select>
            </div>
            <div>
                <label for="pa_id" >Patient Id</label>
                <input id="" class="block mt-1 w-full" type="text" name="pa_id" value="" required autofocus autocomplete="address" >
            </div>

<div>
    <button type="submit" name="submit" class="btn btn-primary">Submit</button>
</div>
</form>
</body>
</html>
