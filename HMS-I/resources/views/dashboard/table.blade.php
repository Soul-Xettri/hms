<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Doctor Table</title>

    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css">
    <link href="assets/css/table.css" rel="stylesheet" />
    

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300" rel="stylesheet" type="text/css">

    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/bootstrap-table/dist/bootstrap-table.min.js"></script>



</head>
<body>
    <div class="wrapper">
      <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="description">
                        <h2>Table </h2>
                    </div>

                    <div class="fresh-table full-color-orange">

                      <div class="bootstrap-table bootstrap3">
                      <div class="fixed-table-toolbar">
                        <div class="bs-bars pull-left">
                    <div class="toolbar">
                      <a href="{{route('dashm')}}" id="alertBtn" class="btn btn-default">Dashboard</a>
                   </div>
                      </div>
                     <div class="columns columns-right pull-right btn-group pull right">
                        <button class="btn btn-default" type="button"  name="refresh" aria-label="refresh" title="Refresh">
                          <i class="glyphicon glyphicon-refresh icon-refresh"></i>
                     </div> 

                     

                   <div class="pull-right search input-group">
                    <form action="">
                     
                    <input class="form-control search-input" type="search" id="search" autocomplete="off" placeholder="Search" >
                     <div class="columns columns-right pull-right btn-group pull right">
                    <!-- <button  class="btn btn-default"  name="search">Search</button></div> form submit button -->
                    </form>
                   </div>
                   
                   </div>
                   <div clas="fixed-table-container" style="padding-bottom: 0px;">
                    <div class="fixed-table-header" style="display: none;">
                      <table></table>

                    </div>
                    <div class="fixed-table-body">
                      <div class="fixed-table-loading table table-hover table-striped" style="top:57px;"> 
                        <span></span>
                      </div>
                        <table id="fresh-table" class="table">
                            <thead>
                                <th data-field="id">ID</th>
                                <th data-field="name" data-sortable="true">First Name</th>

                                <th data-field="actions" data-formatter="operateFormatter" data-events="operateEvents">Actions</th>
                            </thead>
                            <tbody>
                            <tr>
                            @foreach($doctor as $doctors)
                           
                              <tr>
                                <td>{{ $doctors->dc_id }}</td>
                                <td>{{ $doctors->fname }}</td>
                                
                                <td>
                                <a href="{{url('/doctor/delete/')}}/{{$doctors->dc_id}} ">
                                <button class="btn btn-danger">Delete</button>

                                </a>

                                <a href="{{url('/doctor/edit/')}}/{{$doctors->dc_id}}">
                                <button class="btn btn-primary">Edit</button>
                              </a>
                              </td>
                            </tr>
                               
                              @endforeach
                            </tbody>
                        </table>
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