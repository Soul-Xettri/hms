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
</nav>
  
</nav>
</head>
<body>

    <form method="post" action="{{route('pa.save')}}" enctype="multipart/form-data">
        
    @csrf 
    <h1 >Patient Registration </h1>
    <div class="form-group">
    

    <div class="form-grop">
       
    <label for="fname">fisrt-name</label>
                <input id="" class="block mt-1 w-full" type="text" name="fname" value="" >
            </div>
            <div>
                <label for="lname">Last name</label>
                <input id="" class="block mt-1 w-full" type="text" name="lname" value="" required autofocus autocomplete="lname" >
            </div>
            <div>
                <label for="address" >Address</label>
                <input id="" class="block mt-1 w-full" type="text" name="address" value="" required autofocus autocomplete="address" >
            </div>
            <div>
                <label for="city" >City</label>
                <input id="" class="block mt-1 w-full" type="text" name="city" value="" required autofocus autocomplete="address" >
            </div>
            <div>
                <label for="pnm" >Phone number</label>
                <input id="" class="block mt-1 w-full" type="number" name="pnm" value="" required autofocus autocomplete="pnm" >
            </div>
            <div>
            <label>Gender:</label><br>
        <input type="radio" id="male" name="gender" value="M" 
        >
        <label for="male">Male</label>

        <input type="radio" id="female" name="gender" value="F" 
        >
        <label for="female">Female</label>

        <input type="radio" id="other" name="gender" value="O" 
        >
        <label for="other">Other</label><br>
            </div>
            <div>
                <label for="age">Age</label>
                <input id="" class="block mt-1 w-full" type="number" name="age" value="" required autofocus autocomplete="age">
            </div>

            <div class="mt-4">
                <label for="email" >Email</label>
                <input id="email" class="block mt-1 w-full" type="email" name="email" value="" required autocomplete="username" >
            </div>

            <div class="mt-4"> 
                <label for="password" value="" >Password</label>
                <input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="password">
                    <span class="text-danger">
                        @error('password')
                        {{$message}}
                        @enderror
                    </span>
            </div>

            <div class="mt-4">
                <label for="password_confirmation" value="">Confirm Password</label>
                <input id="password_confirmation" class="block mt-1 w-full" type="password" name="password_confirmation" required autocomplete="password_confirmation" >
                <span>
                    
                        @error('password_confirmation') 
                        {{$message}}
                        @enderror
                    </span>
            </div>
<div>   
    <label></label>
    <input type="file" name="img1"class="form-control">
</div>
<div class="form-group">
            <label for="role">Role</label>
            <select class="form-control" id="role" name="role" required>
                <option value="Doctor">Doctor</option>
                <option value="Nurse">Nurse</option>
                <option value="Patient">Patient</option>
            </select>
        </div>
   
<div>
    <button type="submit" name="submit" class="btn btn-primary">Submit</button>
</div>
</form>
</body>
</html>
