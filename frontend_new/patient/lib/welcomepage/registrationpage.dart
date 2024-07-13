import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'loginpage.dart'; // Import the login page

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pnmController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGender;
  XFile? _selectedImage;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      String firstName = _firstController.text;
      String lastName = _lastController.text;
      String address = _addressController.text;
      String city = _cityController.text;
      String pnm = _pnmController.text;
      String age = _ageController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;
      String dob = _selectedDate != null ? _selectedDate.toString() : '';
      String gender = _selectedGender ?? '';
      String imagePath = _selectedImage?.path ?? '';

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://127.0.0.1:8000/api/paregister'));
      request.fields['fname'] = firstName;
      request.fields['lname'] = lastName;
      request.fields['address'] = address;
      request.fields['city'] = city;
      request.fields['pnm'] = pnm;
      request.fields['age'] = age;
      request.fields['dob'] = dob;
      request.fields['gender'] = gender;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['password_confirmation'] = confirmPassword;
      request.fields['role'] = 'Patient';
      if (imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('img1', imagePath));
      }

      var response = await request.send();

      Navigator.of(context).pop(); // Close the loader

      print('Response status code: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
      var responseData = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 4),
              content: Text('Successfully Registered')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 4),
              content: Text('Email or Phone Number already registered')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 4),
              content: Text('Registration failed: ${responseData['message']}')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text =
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/image/registration.png',
                        width: 70,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Enter your personal information',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF9E9E9E),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _firstController,
                    labelText: 'First Name',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _lastController,
                    labelText: 'Last Name',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _addressController,
                    labelText: 'Address',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _cityController,
                    labelText: 'City',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _pnmController,
                    labelText: 'PNM',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _ageController,
                    labelText: 'Age',
                  ),
                  const SizedBox(height: 20.0),
                  _buildDateField(context),
                  const SizedBox(height: 20.0),
                  _buildDropdownField(),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isPassword: true,
                    isVisible: _passwordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    isPassword: true,
                    isVisible: _confirmPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _selectImage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Upload Image'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String labelText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isPassword,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isVisible,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _dobController,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      hint: const Text('Select Gender'),
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
      items:
          <String>['M', 'F', 'O'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}
