import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-api-base-url.com'; // Replace with your API base URL

  static Future<List<dynamic>> fetchMedicalRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/medical-records'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load medical records');
    }
  }

  // Add other API methods as needed, like uploading images, updating records, etc.
}
