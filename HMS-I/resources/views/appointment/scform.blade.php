
<!DOCTYPE html>
<head><nav class="navbar navbar-default navbar-">
<nav class="navbar navbar-default navbar-">
    <!-- @if(session()->has('name'))
        {{session()->get('name')}}
    @else
    Guest
    @endif -->
    <style>
        /* Define CSS rules for available and unavailable options */
        .available {
            color: green;
        }

        .unavailable {
            color: red;
        }
        .booked {
    color: red; /* Example: Change text color to red for booked slots */
}
    </style>
    
</nav>
   
</nav>
<meta name="csrf-token" content="{{ csrf_token() }}">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <form method="post" action="{{route('sc.save')}}" enctype="multipart/form-data">
        
    @csrf 
    <h1 >Schedule</h1>
    </div>
            <div>
    <br>
            <label> Select doctor</label>
                <select class="form-control" name="dc_id" >
                    @foreach ($doctor as $doc )
                    <option value="{{ $doc->dc_id}}">{{$doc->fname}}</option>
                    
                    @endforeach
                </select>
            </div>      </div>
            <div>
    <br>
 
     

    <div class="form-group">
    <label for="apt-date">Date</label>
    <input id="apt-date" class="block mt-1 w-full" type="date" name="apt_date" value="" required >
</div>
            
    <div class="form-group">
       
       <label for="apt-time">Time</label>
                  
                   <select id="apt-time" class="block mt-1 w-full" name="apt_time" required class="form-select">
           
                       </select>
    </div>
@php

    $sname = session()->get('fname');
    $pid = session()->get('pid');
@endphp
                <div class="form-control">
                    <label >Patientaa</label>
                <input id="pa_id" class="block mt-1 w-full" type="text" name="pa_id" value="" required autofocus autocomplete="" >
      

                <h1> {{$sname }} {{$pid}}</h1>
                </div>
               <div class="form-group" >
                 <label for="treat">Treatments</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="treat" value="{{old('treat')}}" >
            </div>
            <div class="form-group" >
                 <label for="pres">Medication</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="pres" value="{{old('pres')}}" >
            </div>
            <div class="form-group" >
                 <label for="pres">Problem Statement</label>
                <input id="" class="block mt-1 w-full black-text" type="text" name="pst" value="" >
            </div>
<div>
    <button type="submit" name="submit" class="btn btn-primary">Submit</button>
</div>
</form>

<script>
   jQuery(document).ready(function() {
    const $starttimeh = '{{ $starttime }}';
    const $endtimeh = '{{ $endtime }}';
    //let timeOptions = '';

    $('#apt-date').change(function() {
        console.log('Date changed.');
        const selectedDate = $(this).val();
        const formattedDate = selectedDate.split('/').reverse().join('-');
        const doctorId = $('select[name="dc_id"]').val();

        const csrfToken = $('meta[name="csrf-token"]').attr('content');
        
        $.ajax({
            url: '/sc-check',
            type: 'POST',
            headers: {
                'X-CSRF-TOKEN': csrfToken
            },
            data: {
                'dc_id': doctorId,
                'apt-date': selectedDate
            },
            dataType: 'json',
            success: function(response) {
                console.log('Script successfully hit the server.');
                console.log('Booked slots:', response.bookedSlots);

                $('#apt-time').empty();
                console.log('Booked slots:', response.starttime); 
                console.log('Booked slots:', response.endtime);
                let starttimeh = parseInt(response.starttime);
                let endtimeh = parseInt(response.endtime);
                 let bookedSlots = response.bookedSlots;
                
                

                 bookedSlots = bookedSlots.filter((value, index, self) => { return self.indexOf(value) === index;});
                 let selectedTime = $('#apt-time').val();
                 selectedTime = selectedTime ? selectedTime.toString() : '';

                for (let i = starttimeh; i <= endtimeh; i++) { 
                    let currentTimeSlot = i.toString().padStart(2, '0') + ':00:00';

                    if (currentTimeSlot !== selectedTime && !bookedSlots.includes(currentTimeSlot)) {
                    const timeString = i.toString().padStart(2, '0') + ':00:00' ;
                    const option = $('<option>').text(timeString).val(timeString);
                   
                
            $('#apt-time').append(option);
                    }
          }
        },
                
            error: function(xhr) {
                console.error('Error retrieving booked time slots.');
                console.error('Response:', xhr.responseText);
            }
        });
    });
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; // January is 0
        var yyyy = today.getFullYear();

        if (dd < 10) dd = '0' + dd;
        if (mm < 10) mm = '0' + mm;

        today = yyyy + '-' + mm + '-' + dd;
        document.getElementById("apt-date").setAttribute("min", today);
    });
</script>

</body>
</html>
