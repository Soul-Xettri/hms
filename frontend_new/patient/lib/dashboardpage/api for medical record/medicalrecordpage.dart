import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _image; // Variable to store selected image file

  Future<void> _getImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error picking image')),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    // Implement your image uploading logic here
    try {
      // Placeholder code to simulate uploading
      // Replace this with your actual upload logic
      await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );

      // Reset the image after successful upload
      setState(() {
        _image = null;
      });
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Medical Record'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: _image != null
                  ? Image.file(
                      _image!,
                      height: 300,
                    )
                  : const Icon(
                      Icons.image,
                      size: 300,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery); // Opens gallery to pick image
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.green,
              ),
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Medical Records',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMedicalRecordCard(
                'Blood Test Report', 'assets/image/report1.jpg'),
            const SizedBox(height: 16),
            _buildMedicalRecordCard('X-Ray Report', 'assets/image/report2.jpg'),
            const SizedBox(height: 16),
            _buildMedicalRecordCard(
                'MRI Scan Report', 'assets/image/report3.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalRecordCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Image.asset(
          imagePath,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.download, color: Colors.blue),
          onPressed: () {
            // Implement your download logic here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Downloading report...')),
            );
          },
        ),
      ),
    );
  }
}
