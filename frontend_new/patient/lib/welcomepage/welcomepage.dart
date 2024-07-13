import 'package:flutter/material.dart';
import 'loginpage.dart'; // Import the login page
import 'registrationpage.dart'; // Import the registration page

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set a clean white background
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/image/logo.png',
                  // Adjusted height for a better fit
                ),
                SizedBox(height: 20.0), // Increased spacing for balance
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/image/logo1.png',
                      width: 45,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 32.0, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800], // Professional color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0), // Added spacing
                Text(
                  'Explore Our Comprehensive',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700], // Professional color
                  ),
                  textAlign:
                      TextAlign.center, // Centered text for better alignment
                ),
                Text(
                  'Medical Facilities',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0), // Added spacing
                Text(
                  'Our experienced team and state-of-the-art facilities ensure you receive exceptional care. From routine check-ups to specialized treatments, we are here for you every step of the way.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600], // Slightly lighter color
                  ),
                  textAlign:
                      TextAlign.center, // Centered text for better alignment
                ),
                SizedBox(height: 30.0), // Increased spacing for balance
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20.0, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color for contrast
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800], // Button color
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20.0, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color for contrast
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800], // Button color
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                      ),
                    ),
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
