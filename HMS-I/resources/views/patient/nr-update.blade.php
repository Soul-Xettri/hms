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
        <button class="btn btn-primary"> patients</button>
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
</nav>
  
</nav>
</head>
<body>

    <form method="post" action="{{route('pa.update',['id' => $patient->pa_id])}}" enctype="multipart/form-data">
        
    @csrf 
    <h1 >Update  Patient </h1>
    <div class="form-group">
    

    <div class="form-grop">
       
    <label for="fname">fisrt-naame</label>
                <input id="" class="block mt-1 w-full" type="text" name="fname" value="{{old('fname', $patient->fname)}}" >
            </div>
            <div>
                <label for="lname">Last name</label>
                <input id="" class="block mt-1 w-full" type="text" name="lname" value="{{old('lname', $patient->lname)}}" required autofocus autocomplete="lname" >
            </div>
            <div>
                <label for="address" >Address</label>
                <input id="" class="block mt-1 w-full" type="text" name="address" value="{{old('address', $patient->address)}}" required autofocus autocomplete="address" >
            </div>
            <div>
                <label for="city" >City</label>
                <input id="" class="block mt-1 w-full" type="text" name="city" value="{{old('city', $patient->city)}}" required autofocus autocomplete="address" >
            </div>
            <div>
                <label for="pnm" >Phone number</label>
                <input id="" class="block mt-1 w-full" type="number" name="pnm" value="{{old('pnm', $patient->pnm)}}" required autofocus autocomplete="pnm" >
            </div>
            <div>
            <label>Gender:</label><br>
        <input type="radio" id="male" name="gender" value="M" 
        {{$patient->gender=="M"? "checked":""}}>
        <label for="male">Male</label>

        <input type="radio" id="female" name="gender" value="F" 
        {{$patient->gender=="F"? "checked":""}}>
        <label for="female">Female</label>

        <input type="radio" id="other" name="gender" value="O" 
        {{$patient->gender=="O"? "checked":""}}>
        <label for="other">Other</label><br>
            </div>
            <div>
                <label for="age">Weight</label>
                <input id="" class="block mt-1 w-full" type="number" name="weight" value="{{old('weight', $patient->weight)}}" required autofocus autocomplete="age">
            </div>
            <div>
                <label for="weight">Age </label>
                <input id="" class="block mt-1 w-full" type="number" name="age" value="{{old('age', $patient->age)}}" required autofocus autocomplete="age">
            </div>
            

            <div>
                <label for="description" >Description</label>
                <input id="" class="block mt-1 w-full" type="text" name="description" value="{{old('description', $patient->description)}}" required autofocus autocomplete="address" >
            </div>
            <div>
                <label for="mh" >Medical History</label>
                <input id="" class="block mt-1 w-full" type="text" name="mh" value="{{old('mh', $patient->mh)}}" required autofocus autocomplete="address" >
            </div>
            <label>Status:</label><br>
            <input type="radio" id="" name="status" value="InPatient" 
        {{$patient->status=="0"? "checked":""}}>
        <label for="male">Male</label>
        <input type="radio" id="" name="status" value="OutPatient" 
        {{$patient->status=="1"? "checked":""}}>
        <label for="male">Male</label>
        <br>

            
      

   
<div>
    <button type="submit" name="submit" class="btn btn-primary">Update</button>
</div>
</form>
</body>
</html>
