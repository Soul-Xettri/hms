import 'package:flutter/material.dart';
import 'package:frontend_new/welcomepage/welcomepage.dart';
import '../dashboardpage.dart';
import '../api for profile/profile.dart';
import 'setting/settingpage.dart';

void main() {
  runApp(MaterialApp(
    home: PatientPage(),
  ));
}

class PatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardPage()), // Navigate back to the dashboard
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              child: const Column(
                children: [
                  SizedBox(height: 10.0),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/image/doctor.jpg'), // Add your avatar image path
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Ram bahadur',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  _buildProfileListOption(
                      'Settings', Icons.settings, Colors.red, context),
                  _buildProfileListOption(
                      'Sign Out', Icons.logout, Colors.red, context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileListOption(
      String title, IconData icon, Color color, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 41, 9, 226)),
      onTap: () {
        // Navigate to the respective page based on the title
        if (title == 'Settings') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        } else if (title == 'Sign Out') {
          _showLogoutDialog(context);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 50,
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Text('Logout'),
            ],
          ),
          content: const Text(
              'Thank You for using Mero Doctor\n\nAre you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // foreground
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                // Implement your logout functionality here
                // For example, navigate to a sign-out page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
