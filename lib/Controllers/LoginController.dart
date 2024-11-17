import 'dart:convert'; 
import 'package:flutter/material.dart'; // Import Flutter material
import 'package:get/get.dart';
import 'package:khedme/Routes/AppRoute.dart'; // Import your AppRoute
import 'package:khedme/Services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences
import 'package:khedme/Services/booking_service.dart';

class LoginController extends GetxController {
  final AuthService authService = AuthService();
  var errorMessage = ''.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final BookingService bookingService = BookingService(); // Ensure the booking service is initialized

  Future<void> login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      errorMessage.value = 'Please fill in all fields';
      Get.snackbar('Error', errorMessage.value);
      return;
    }

    try {
      print('Attempting login with email: ${email.text}');

      final response = await authService.login(email.text, password.text);

      // Check the response status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('access_token')) {
          final token = data['access_token'];
          final userId = data['data']['id'];
          
          // Print user_id after successful login
          // print('User ID: $userId'); // Print user ID
          
          // await fetchUserOrders(token); // Fetch orders after login
          await checkUserId();
          await storeToken(token);
          await storeUserId(userId.toString());

          print('Login successful, access token: $token');
          Get.snackbar('Success', 'Login successful');
          Get.offNamed(AppRoute.home);
        } else {
          errorMessage.value = 'Unexpected response structure';
          Get.snackbar('Error', errorMessage.value);
          print('Unexpected response data: $data');
        }
      } else {
        errorMessage.value = 'Login failed: Invalid credentials';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar('Error', errorMessage.value);
      print('Error during login: $e');
    } finally {
      print('Login process completed.');
    }
  }

  // Methods to store token and user ID
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> storeUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<void> fetchUserOrders(String token) async {
    try {
      final response = await bookingService.getBookings(token); // Call getBookings instead of getOrders

      if (response.statusCode == 200) {
        final List<dynamic> orders = jsonDecode(response.body);
        print('User Orders: $orders'); // Print the orders for verification
      } else {
        print('Failed to retrieve orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error retrieving orders: $e');
    }
  }
}
