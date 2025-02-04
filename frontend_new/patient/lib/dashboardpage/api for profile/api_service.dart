import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/';

  static Future<Map<String, dynamic>> fetchProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/paview'));
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  static Future<void> updateProfile(Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profileData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}
