import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboardpage/dashboardpage.dart';
import 'package:http/http.dart' as http;
import '../dashboardpage/api for resetpassword/passwordresetpage.dart';
import '../global.dart' as globals;
import '../Controller/AccController.dart';
import '../model/AccModel.dart';

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
    super.initState();
    _passwordVisible = false;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      Uri url = Uri.parse('http://127.0.0.1:8000/api/login');
      var response = await http.post(url, body: {
        "email": _usernameController.text,
        "password": _passwordController.text,
      });

      Navigator.of(context).pop(); // Close the loader

      try {
        if (response.statusCode == 200) {
          var jsonResult = jsonDecode(response.body);
          var result = Accmodel.fromJson(jsonResult);
          var userName = result.value?.fname;
          context.read<PaDataProvider>().setLoginStatusActive();
          context.read<PaDataProvider>().setUserLoginData(result);
          print(result);
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(
                      firstName: userName,
                    )),
          );
        } else {
          _showErrorDialog('Invalid email or password');
        }
      } catch (e) {
        _showErrorDialog('An error occurred. Please try again.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/image/logo1.png', height: 150.0),
                const SizedBox(height: 30.0),
                _buildTextField(
                  controller: _usernameController,
                  labelText: 'Email',
                  validator: _emailValidator,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20.0),
                _buildPasswordField(
                  controller: _passwordController,
                  labelText: 'Password',
                  validator: _passwordValidator,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18.0)),
                ),
                TextButton(
                  onPressed: _navigateToResetPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: validator,
    );
  }
}
