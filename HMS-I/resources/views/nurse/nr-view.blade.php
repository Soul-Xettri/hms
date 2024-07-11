<!doctype html>
<html lang="en">
  <head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <nav class="navbar navbar-default navbar-">
      
    <nav class="navbar navbar-default navbar-">
    <!-- @if(session()->has('name'))
        {{session()->get('name')}}
    @else
    Guest
    @endif -->
  
   <div><a href="{{route('pa.home')}}">
        <button class="btn btn-primary"> Home</button>
        </a></div>
    <div ><a href="{{route('pa.add')}}">
        <button class="btn btn-primary"> Add patients</button>
        </a></div>
    <div >
        <a href="{{route('pa.view')}}">
        <button class="btn btn-primary">View Patients</button>
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
</nav>
  </nav>
  <div>
  
  </div>
  </head>
  <body>
  
      <div class="container">
      <table class="table">
  <thead>
    <tr>
      <th>FName</th>
      <th>LName</th>
      <th>Address</th>
      <th>City</th>
      <th>Phone number</th>
      <th>Gender</th>
      <th>Age</th>
      <th>Email</th>
      <th>Img</th>
      <th>Action</th>
      
    </tr>
  </thead>
  <tbody>
  @foreach($nurse as $nurses)
    <tr>
        <td>{{ $nurses->fname }}</td>
        <td>{{ $nurses->lname }}</td>
        <td>{{ $nurses->address }}</td>
        <td>{{ $nurses->city }}</td>
        <td>{{ $nurses->pnm }}</td>
        <td>{{ $nurses->gender }}</td>
        <td>{{ $nurses->age }}</td>
        <td>{{ $nurses->email }}</td>
        <td>
          <img src="{{ asset($nurses->img1)}}" style="width: 70px; height: 70px;" alt="Img not aviable" />
</td>
        <td>
          <a href="{{url('/nurse/delete/')}}/{{$nurses->nr_id}} ">
          <button class="btn btn-danger">Delete</button>
        
          </a>
     
          <a href="{{url('/nurse/edit/')}}/{{$nurses->nr_id}}">
          <button class="btn btn-primary">Edit</button>
        </a>
        </td>
        
       
    </tr>
@endforeach

    </tbody>
  </table>

</div>
  </body>
</html>