import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_new/Controller/AccController.dart';
import 'package:frontend_new/model/AccModel.dart';
import 'package:provider/provider.dart';
import '../dashboardpage/dashboardpage.dart';
import 'package:http/http.dart' as http;
import '../dashboardpage/api for resetpassword/passwordresetpage.dart';
import '../global.dart' as globals;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Login Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DashboardPage(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  Future<void> register(BuildContext context) async {
    print('yeta chu hai ma');
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      Uri url = Uri.parse('http://127.0.0.1:8000/api/login');
      var response = await http.post(url, body: {
        "email": _usernameController.text,
        "password": _passwordController.text,
      });
      try {
        if (response.statusCode == 200) {
          var jsonResult = jsonDecode(response.body);
          var result = Accmodel.fromJson(jsonResult);
          var userName = result.value?.fname;
          context.read<PaDataProvider>().setLoginStatusActive();
          context.read<PaDataProvider>().setUserLoginData(userName!);
          Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardPage(
                        firstName: userName,
                      )));
        } else {
          print('error');
        }
      } catch (e) {
        print("Exception occured"); // Write your exception code
      }
    } else {
      // Perform action if validation is failed
      print("Validation failed");
    }
  }

  // }

  void _navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordResetPage()),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  //  (validation ko lagi)
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 6 characters long and contain uppercase, lowercase, digit, and special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 1.0),
                  Image.asset('assets/image/logo1.png', height: 300.0),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      String pattern =
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // if (value.length < 8) {
                      //   return 'Password must be at least 8 characters long';
                      // }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: _navigateToResetPassword,
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
