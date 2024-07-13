import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String pnm;
  final String gender;
  final double weight;
  final int age;
  final double height;
  final Function(
          String, String, String, String, String, String, double, int, double)
      onSave;

  EditProfilePage({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.pnm,
    required this.gender,
    required this.weight,
    required this.age,
    required this.height,
    required this.onSave,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _pnmController;
  late TextEditingController _genderController;
  late TextEditingController _weightController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _addressController = TextEditingController(text: widget.address);
    _cityController = TextEditingController(text: widget.city);
    _pnmController = TextEditingController(text: widget.pnm);
    _genderController = TextEditingController(text: widget.gender);
    _weightController = TextEditingController(text: widget.weight.toString());
    _ageController = TextEditingController(text: widget.age.toString());
    _heightController = TextEditingController(text: widget.height.toString());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pnmController.dispose();
    _genderController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_firstNameController, 'First Name'),
                    _buildTextField(_lastNameController, 'Last Name'),
                    _buildTextField(_addressController, 'Address'),
                    _buildTextField(_cityController, 'City'),
                    _buildTextField(_pnmController, 'Phone Number'),
                    _buildTextField(_genderController, 'Gender'),
                    _buildTextField(_weightController, 'Weight (kg)',
                        isNumeric: true),
                    _buildTextField(_ageController, 'Age', isNumeric: true),
                    _buildTextField(_heightController, 'Height (cm)',
                        isNumeric: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.onSave(
                          _firstNameController.text,
                          _lastNameController.text,
                          _addressController.text,
                          _cityController.text,
                          _pnmController.text,
                          _genderController.text,
                          double.tryParse(_weightController.text) ?? 0,
                          int.tryParse(_ageController.text) ?? 0,
                          double.tryParse(_heightController.text) ?? 0,
                        );
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child:
                          const Text('Save', style: TextStyle(fontSize: 18.0)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
