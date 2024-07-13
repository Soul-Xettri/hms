import 'package:flutter/material.dart';

class MyPrescriptionPage extends StatefulWidget {
  @override
  _MyPrescriptionPageState createState() => _MyPrescriptionPageState();
}

class _MyPrescriptionPageState extends State<MyPrescriptionPage> {
  String selectedDoctor = '--Choose Doctor--';
  List<String> doctors = [
    '--Choose Doctor--',
    'Dr. John Doe',
    'Dr. Jane Smith'
  ];
  List<Map<String, String>> prescriptions = [];
  List<Map<String, String>> filteredPrescriptions = [];

  @override
  void initState() {
    super.initState();
    // Adding some dummy data for demonstration purposes
    prescriptions = [
      {
        'date': '2023-07-15',
        'doctor': 'Dr. John Doe',
        'medication': 'Amoxicillin 500mg',
        'instructions': 'Take one capsule every 8 hours for 7 days.'
      },
      {
        'date': '2023-06-10',
        'doctor': 'Dr. Jane Smith',
        'medication': 'Ibuprofen 200mg',
        'instructions': 'Take one tablet every 6 hours as needed for pain.'
      }
    ];

    // Initialize filteredPrescriptions with all prescriptions
    filteredPrescriptions = prescriptions;
  }

  void _filterPrescriptions(String doctor) {
    setState(() {
      if (doctor == '--Choose Doctor--') {
        filteredPrescriptions = prescriptions;
      } else {
        filteredPrescriptions = prescriptions
            .where((prescription) => prescription['doctor'] == doctor)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Prescription'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedDoctor,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedDoctor = newValue;
                  });
                  _filterPrescriptions(newValue);
                }
              },
              items: doctors.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPrescriptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${filteredPrescriptions[index]['date']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Doctor: ${filteredPrescriptions[index]['doctor']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Medication: ${filteredPrescriptions[index]['medication']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Instructions: ${filteredPrescriptions[index]['instructions']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
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
