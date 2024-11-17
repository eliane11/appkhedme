import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khedme/Models/Worker.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8000/api';

  Uri buildUrl(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  Map<String, String> getHeaders(String token) {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  // This login method returns the full response, typically used for error handling or custom processing
  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      buildUrl('/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log in: ${response.statusCode} ${response.body}');
    }

    return response;
  }
  Future<List<KhedmeWorker>> fetchWorkersByService(String service) async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/workers/$service'));

    // Log the response status and body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> workersJson = json.decode(response.body);
      return workersJson.map((json) => KhedmeWorker.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workers');
    }
  }



}