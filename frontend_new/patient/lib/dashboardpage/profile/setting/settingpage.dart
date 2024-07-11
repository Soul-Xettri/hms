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
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Choose Language dropdown (Placeholder)
          ListTile(
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
            title: Text('Enable Notification'),
            value: true, // Replace with your actual value
            onChanged: (bool value) {
              // Implement notification enable/disable logic here
            },
          ),
          // App Version (Placeholder)
          ListTile(
            title: Text('App Version'),
            subtitle: Text('0.0.1'),
          ),
          // Terms & Conditions
          ListTile(
            title: Text('Terms & Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsAndPoliciesScreen()),
              );
            },
          ),
          // Divider
          Divider(),
          // Change Password
          ListTile(
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
