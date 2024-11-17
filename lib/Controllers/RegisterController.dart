import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class RegisterController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();


  // Register user function
  Future<bool> register() async {
    const String url = 'http://localhost:8000/api/register';

    try {
      final Map<String, dynamic> body = {
        'first_name': firstName.text,
        'last_name': lastName.text,
        'email': email.text,
        'phone': phone.text,
        'address': address.text,
        'password': password.text,
        'password_confirmation': confirmPassword.text, // Added confirmation
      };

      // Make the request
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      // Check if registration was successful
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print('Registration successful: $responseBody');
        Get.offNamed('/login'); // Use Get.offNamed to remove the Register page from the stack

        return true; // Indicate success
      } else {
        print('Registration failed: ${response.body}');
        return false; // Indicate failure
      }
    } catch (e) {
      print('Unexpected error: $e');
      return false; // Indicate failure
    }
  }
}
