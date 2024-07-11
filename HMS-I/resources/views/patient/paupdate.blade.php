<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Patient Update</title>

    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="/assets/css/table.css" rel="stylesheet" />
    

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300" rel="stylesheet" type="text/css">

    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table/dist/bootstrap-table.min.js"></script>
<style>
    input[type="text"]{
        color: black;
    
    }
    .black-text{
        color: black;
    }
</style>


</head>
<body>
    <div class="wrapper">
      <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="description">
                        <h2>Update Form</h2>
                    </div>

                    <div class="fresh-table full-color-blue">

                      <div class="bootstrap-table bootstrap3">
                      <div class="fixed-table-toolbar">
                        <div class="bs-bars pull-left">
                    <div class="toolbar">
                      <a href="{{route('dashm')}}" id="alertBtn" class="btn btn-default">Dashboard</a>
                   </div>
                      </div>
                     </div>
                   <div clas="fixed-table-container" style="padding-bottom: 0px;">
                    <div class="fixed-table-header" style="display: none;">
                      <table></table>

                    </div>
                    <div class="fixed-table-body">
                      <div class="fixed-table-loading table table-hover table-striped" style="top:57px;"> 
                        <span></span>
                    
                        
                            <div class="form-group" >
                 <label for="fname">First Name</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="fname" value="{{old('fname', $patient->fname)}}" >
            </div>
            <div class="form-group">
                <label for="lname">Last Name</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="lname" value="{{old('lname', $patient->lname)}}" required autofocus autocomplete="lname" >
            </div>
            <div class="form-group">
                <label for="address" >Address</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="address" value="{{old('address', $patient->address)}}" required autofocus autocomplete="address" >
            </div>
            <div class="form-group">
                <label for="city" >City</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="city" value="{{old('city', $patient->city)}}" required autofocus autocomplete="address" >
            </div>
            <div class="form-group">
                <label for="pnm" >Phone number</label>
                <input id="" class="block mt-1 w-full black-text" type="number" name="pnm" value="{{old('pnm', $patient->pnm)}}" required autofocus autocomplete="pnm" >
            </div>
            <div class="form-group">
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
            <div class="form-group">
                <label for="age">Age</label>
                <input id="" class="block mt-1 w-full black-text" type="number" name="age" value="{{old('age', $patient->age)}}" required autofocus autocomplete="age">
            </div>

            <div class="form-group">
                <label for="email" >Email</label>
                <input id="email" class="block mt-1 w-full black-text" type="email" name="email" value="{{old('email', $patient->email)}}" required autocomplete="username" >
            </div>

            <div class="form-group">
                <label for="password" value="" >Password</label>
                <input id="password" class="block mt-1 w-full black-text" type="password" name="password" required autocomplete="password">
                    <span class="text-danger">
                        @error('password')
                        {{$message}}
                        @enderror
                    </span>
            </div>

            <div class="form-group">
                <label for="password_confirmation" value="">Confirm Password</label>
                <input id="password_confirmation" class="block mt-1 w-full black-text" type="password" name="password_confirmation" required autocomplete="password_confirmation" >
                <span>
                    
                        @error('password_confirmation')
                        {{$message}}
                        @enderror
                    </span>
            </div>

   
<div>
    <button type="submit" name="submit" class="btn btn-primary">Update</button>
</div>
    </div>
    </div>
</form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>
</body>
                       
</html>