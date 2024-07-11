import 'package:flutter/material.dart';
import 'package:frontend_new/dashboardpage/dashboardpage.dart';
import 'package:frontend_new/dashboardpage/searchpage.dart';
import 'loginpage.dart'; // Import the login page
import 'registrationpage.dart'; // Import the registration page

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/image/logo.png', height: 300.0),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/image/logo1.png',
                      width: 45, // Set the desired width
                      height: 50, // Set the desired height
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 0.0),
                Text(
                  'Explore Our Comprehensive',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 0.0),
                Text(
                  'Medical Facilities',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 0.0),
                const Text(
                  'our experience team and state of the art facalities ensures you recieve exceptional care. From routine check-ups to specialized treatments. we are here for you every steps of the way.',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
