import 'package:flutter/material.dart';
import 'api_service.dart';
import 'editprofilepage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = 'Ram bahadur';
  String lastName = 'Gurung';
  String address = 'Bhajapatan';
  String city = 'Pokhara';
  String pnm = '01';
  String gender = 'male';
  double weight = 70;
  int age = 20;
  String description = 'Healthy';

  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final profile = await ApiService.fetchProfile();

      setState(() {
        firstName = profile['firstName'];
        lastName = profile['lastName'];
        address = profile['address'];
        city = profile['city'];
        pnm = profile['pnm'];
        gender = profile['gender'];
        weight = profile['weight'];
        age = profile['age'];
        description = profile['description'];
        isLoading = false; // Reset loading state
      });
    } catch (e) {
      // Handle error
      print('Error fetching profile: $e');
      setState(() {
        isLoading = false; // Reset loading state on error
      });
    }
  }

  void _updateProfile(
    String newFirstName,
    String newLastName,
    String newAddress,
    String newCity,
    String newPnm,
    String newGender,
    double newWeight,
    int newAge,
    String newDescription,
  ) async {
    setState(() {
      firstName = newFirstName;
      lastName = newLastName;
      address = newAddress;
      city = newCity;
      pnm = newPnm;
      gender = newGender;
      weight = newWeight;
      age = newAge;
      description = newDescription;
    });

    try {
      await ApiService.updateProfile({
        'firstName': newFirstName,
        'lastName': newLastName,
        'address': newAddress,
        'city': newCity,
        'pnm': newPnm,
        'gender': newGender,
        'weight': newWeight,
        'age': newAge,
        'description': newDescription,
      });
    } catch (e) {
      // Handle error
      print('Error updating profile: $e');
      // Optionally revert changes in UI state on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                    _buildProfileInfoRow(Icons.description, description),
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
                              weight: weight,
                              age: age,
                              description: description,
                              onSave: _updateProfile,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text('Update Information'),
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
