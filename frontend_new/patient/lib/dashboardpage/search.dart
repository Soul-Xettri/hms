import 'package:flutter/material.dart';
import 'appoinmentpage.dart'; // Ensure this import path is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class Doctor {
  final String name;
  final String specialization;
  final int experience;
  final double fee;
  final String imageUrl;

  var id;

  Doctor({
    required this.name,
    required this.specialization,
    required this.experience,
    required this.fee,
    required this.imageUrl,
  });
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Darshan Ghale',
      specialization: 'Internal Medicine',
      experience: 5,
      fee: 850,
      imageUrl: 'assets/image/doctor.jpg', // Replace with actual image URLs
    ),
    Doctor(
      name: 'Dr. Safal Koirala',
      specialization: 'Internal Medicine',
      experience: 5,
      fee: 1000,
      imageUrl: 'assets/image/doctor1.jpg',
    ),
    Doctor(
      name: 'Dr. Kiran Sunar',
      specialization: 'Internal Medicine',
      experience: 2,
      fee: 850,
      imageUrl: 'assets/image/doctor2.jpg',
    ),
    Doctor(
      name: 'Dr. Kiran Sunar',
      specialization: 'Internal Medicine',
      experience: 2,
      fee: 850,
      imageUrl: 'assets/image/doctor3.jpg',
    ),
    Doctor(
      name: 'Dr. Kiran Sunar',
      specialization: 'Internal Medicine',
      experience: 2,
      fee: 850,
      imageUrl: 'assets/image/doctor4.jpg',
    ),
    Doctor(
      name: 'Dr. Kiran Sunar',
      specialization: 'Internal Medicine',
      experience: 2,
      fee: 850,
      imageUrl: 'assets/image/doctor5.jpg',
    ),
    // Add more doctor entries here
  ];

  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors;
  }

  void _filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = doctors;
      } else {
        filteredDoctors = doctors
            .where((doctor) =>
                doctor.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Implement back button functionality
          },
        ),
        backgroundColor:
            Colors.blue, // Ensure the AppBar background color is consistent
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: _filterDoctors,
              decoration: InputDecoration(
                hintText: 'Search By Keyword',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DoctorDetailPage(doctor: filteredDoctors[index]),
                        ),
                      );
                    },
                    child: DoctorCard(doctor: filteredDoctors[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(doctor.imageUrl),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(doctor.specialization),
                  Text('Experience: ${doctor.experience} years'),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Rs. ${doctor.fee}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentPage(doctor: doctor),
                      ),
                    );
                  },
                  child: const Text('Book Appointment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Doctor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(doctor.imageUrl),
              ),
              const SizedBox(height: 20),
              _buildProfileInfoRow(Icons.person, doctor.name),
              _buildProfileInfoRow(Icons.healing, doctor.specialization),
              _buildProfileInfoRow(Icons.calendar_today,
                  'Experience: ${doctor.experience} years'),
              _buildProfileInfoRow(Icons.money, 'Fee: Rs. ${doctor.fee}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentPage(doctor: doctor),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Book Appointment',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
