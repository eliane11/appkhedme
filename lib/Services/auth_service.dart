import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService extends ApiService {
  Future<bool> register(String firstName, String lastName, String email, String phone, String address, String password) async {
    final url = buildUrl("/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "password": password,
      }),
    );

    return response.statusCode == 201; // Registration successful
  }

@override
Future<http.Response> login(String email, String password) async {
  final url = buildUrl("/login");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

    if (response.statusCode == 200) {
      return response; // Return entire response
    } else {
      print("Error logging in: ${response.body}");
      throw Exception("Login failed"); // Throw an exception for failed login
    }
  }

  Future<http.Response> getUserDetails(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'), // Ensure this endpoint is correct
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  Future<http.Response> logout(String token) async {
    final url = buildUrl("/logout");

    final response = await http.post(
      url,
      headers: getHeaders(token),
    );

    return response;
  }
}
