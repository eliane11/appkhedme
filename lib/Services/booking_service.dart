// import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class BookingService extends ApiService {
  // Method to add a booking
  Future<http.Response> addBooking(String token, Map<String, dynamic> bookingData) async {
    final url = buildUrl("/add_booking");
    
    final response = await http.post(
      url,
      headers: getHeaders(token),
      // body: jsonEncode(bookingData),
    );

    return response;
  }

  // Method to get bookings (list of bookings)
  Future<http.Response> getBookings(String token) async {
    final url = buildUrl("/bookings");
    
    final response = await http.get(
      url,
      headers: getHeaders(token),
    );

    return response;
  }

  // Method to get orders (assuming orders are similar to bookings)
  Future<http.Response> getOrders(String token) async {
    final url = buildUrl("/orders"); // Update with your actual endpoint for orders

    final response = await http.get(
      url,
      headers: getHeaders(token),
    );

    return response;
  }
}
