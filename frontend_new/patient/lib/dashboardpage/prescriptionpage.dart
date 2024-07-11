


import 'package:flutter/material.dart';

class MyPrescriptionPage extends StatefulWidget {
  @override
  _MyPrescriptionPageState createState() => _MyPrescriptionPageState();
}

class _MyPrescriptionPageState extends State<MyPrescriptionPage> {
  String selectedPatient = '--Choose Patient--';
  List<String> patients = ['--Choose Patient--', 'Kiran Sunar'];
  bool hasPrescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedPatient,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPatient = newValue!;
                  hasPrescription = false; // Reset prescription status when patient changes
                });
              },
              items: patients.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: Center(
                child: hasPrescription
                    ? Text('You have prescriptions')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 50,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No Any Prescription',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // Simulate fetching prescription data
                                hasPrescription = !hasPrescription;
                              });
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}