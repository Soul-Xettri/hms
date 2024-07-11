<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Department Update</title>

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
                        <h2>Department Update Form</h2>
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
                        <form action="{{route('dt.update',['id' => $dpt->dpt_id])}}" method="post">  
                        @csrf   
                        
                <div class="form-group" >
                 <label for="dpt_name">Department Name</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="dpt_name" value="{{old('dpt_name', $dpt->dpt_name)}}" >
            </div>
            <div class="form-group">
            <label for="dpt_des">Description</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="dpt_des" value="{{old('dpt_name', $dpt->dpt_name)}}" required autofocus autocomplete="lname" >
            </div>
           
           

   
<div>
    <button type="submit" name="submit" class="btn btn-primary">Update</button>
</div>
</form>
    </div>
    </div>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>
</body>
                       
</html>