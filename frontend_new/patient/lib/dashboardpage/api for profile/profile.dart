import 'package:flutter/material.dart';
import 'package:frontend_new/Controller/AccController.dart';
import 'package:provider/provider.dart';
import '../dashboardpage.dart';
import 'editprofilepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  Future<void> _updateProfile(
    String newFirstName,
    String newLastName,
    String newAddress,
    String newCity,
    String newPnm,
    String newGender,
    double newWeight,
    int newAge,
    double newHeight,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://127.0.0.1:8000/api/paupdate/1'), // Adjust the ID as needed
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fname': newFirstName,
          'lname': newLastName,
          'address': newAddress,
          'city': newCity,
          'pnm': newPnm,
          'gender': newGender,
          'weight': newWeight.toString(),
          'age': newAge.toString(),
          'mh': newHeight.toString(),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage(firstName: newFirstName)),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle error
        print('Error updating profile: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<PaDataProvider>().account?.value;
    final firstName = data?.fname ?? '';
    final lastName = data?.lname ?? '';
    final address = data?.address ?? '';
    final city = data?.city ?? '';
    final pnm = data?.pnm ?? '';
    final gender = data?.gender ?? '';
    final weight = data?.weight?.toString() ?? '';
    final age = data?.age?.toString() ?? '';
    final height = data?.mh?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('$firstName $lastName'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileInfoRow(Icons.person, '$firstName $lastName'),
                    _buildProfileInfoRow(Icons.location_city, address),
                    _buildProfileInfoRow(Icons.location_on, city),
                    _buildProfileInfoRow(Icons.phone, pnm),
                    _buildProfileInfoRow(Icons.male, gender),
                    _buildProfileInfoRow(Icons.monitor_weight, '$weight kg'),
                    _buildProfileInfoRow(Icons.cake, '$age years old'),
                    _buildProfileInfoRow(Icons.height, '$height cm'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                              firstName: firstName,
                              lastName: lastName,
                              address: address,
                              city: city,
                              pnm: pnm,
                              gender: gender,
                              weight: double.tryParse(weight) ?? 0.0,
                              age: int.tryParse(age) ?? 0,
                              height: double.tryParse(height) ?? 0.0,
                              onSave: _updateProfile,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Update Information',
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
