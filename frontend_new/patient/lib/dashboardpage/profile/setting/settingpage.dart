import 'package:flutter/material.dart';
import 'changepassword.dart'; // Import the ChangePasswordScreen
import 'termsandcondition.dart'; // Import the TermsConditionsScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Choose Language dropdown (Placeholder)
          ListTile(
            leading: Icon(Icons.language, color: Colors.blue[800]),
            title: Text('Choose Language'),
            trailing: DropdownButton<String>(
              value: 'English',
              onChanged: (String? newValue) {
                // Implement language change logic here
              },
              items: <String>['English', 'Nepali'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Enable Notification switch (Placeholder)
          SwitchListTile(
            secondary: Icon(Icons.notifications, color: Colors.blue[800]),
            title: Text('Enable Notification'),
            value: true, // Replace with your actual value
            onChanged: (bool value) {
              // Implement notification enable/disable logic here
            },
          ),
          // App Version (Placeholder)
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue[800]),
            title: Text('App Version'),
            subtitle: Text('0.0.1'),
          ),
          // Terms & Conditions
          ListTile(
            leading: Icon(Icons.policy, color: Colors.blue[800]),
            title: Text('Terms & Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndPoliciesScreen()),
              );
            },
          ),
          // Divider
          Divider(),
          // Change Password
          ListTile(
            leading: Icon(Icons.lock, color: Colors.blue[800]),
            title: Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
