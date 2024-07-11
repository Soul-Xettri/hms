import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart'; // Import the Doctor model
import 'package:intl/intl.dart'; // For formatting dates

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({required this.doctor});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pnmController = TextEditingController(); // Changed from npm to pnm
  final TextEditingController _dateController = TextEditingController();
  String? _selectedTime;

  @override
  void dispose() {
    _nameController.dispose();
    _pnmController.dispose(); // Updated from npm to pnm
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        _selectedTime = null; // Reset selected time when date changes
      });
    }
  }

  Future<void> _bookAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameController.text;
      final String pnm = _pnmController.text; // Updated from npm to pnm
      final String date = _dateController.text;
      final String time = _selectedTime ?? ""; // Ensure time is not null

      // Create the appointment data
      final Map<String, dynamic> appointmentData = {
        'doctorId': widget.doctor.id, // Assuming Doctor model has an 'id' field
        'name': name,
        'pnm': pnm, // Updated from npm to pnm
        'date': date,
        'time': time,
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/appointments'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(appointmentData),
      );

      if (response.statusCode == 200) {
        // Handle success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment Booked!')),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to book appointment.')),
        );
      }
    }
  }

  // Function to fetch available appointment times for the selected date
  Future<List<String>> _fetchAvailableTimes(DateTime date) async {
    // Implement your logic to fetch available times from your API or local data
    // For demonstration purposes, returning dummy data
    await Future.delayed(const Duration(seconds: 1)); // Simulating a delay

    // Dummy available times (replace with actual logic)
    List<String> availableTimes = [
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
    ];

    return availableTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Booking an appointment with ${widget.doctor.name}'),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pnmController, // Updated from npm to pnm
                decoration: const InputDecoration(labelText: 'PNM'), // Updated from npm to pnm
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PNM'; // Updated from npm to pnm
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Preferred Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a preferred date';
                  }
                  return null;
                },
              ),
              if (_dateController.text.isNotEmpty) // Show time selector if date is selected
                FutureBuilder(
                  future: _fetchAvailableTimes(DateTime.parse(_dateController.text)),
                  builder: (context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No available times found.');
                    } else {
                      return DropdownButtonFormField<String>(
                        value: _selectedTime,
                        onChanged: (value) {
                          setState(() {
                            _selectedTime = value;
                          });
                        },
                        items: snapshot.data!.map((time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Preferred Time',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a preferred time';
                          }
                          return null;
                        },
                      );
                    }
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _bookAppointment,
                child: const Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
