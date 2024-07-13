import 'package:flutter/material.dart';
import 'package:frontend_new/Controller/AccController.dart';
import 'package:frontend_new/welcomepage/welcomepage.dart';
import 'package:provider/provider.dart';
import '../dashboardpage.dart';
import '../api for profile/profile.dart';
import 'setting/settingpage.dart';

void main() {
  runApp(MaterialApp(
    home: PatientPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class PatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<PaDataProvider>().account?.value;
    print(data?.role);
    final int paId =
        data?.paId ?? 0; // Assuming pa_id is part of the data model

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
                    DashboardPage(firstName: data?.fname ?? ''),
              ), // Navigate back to the dashboard
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(paId: paId)),
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
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ), // Add your avatar image path
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '${data?.fname ?? 'User'} ${data?.lname ?? ''}',
                    style: const TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  _buildProfileListOption(
                      'Settings', Icons.settings, Colors.blue, context),
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
              MaterialPageRoute(
                builder: (context) =>
                    DashboardPage(firstName: data?.fname ?? ''),
              ),
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
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(
            children: const [
              Icon(
                Icons.logout,
                size: 50,
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Thank you for using Mero Doctor.\n\nAre you sure you want to logout?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Yes', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                // Implement your logout functionality here
                // For example, navigate to a sign-out page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
