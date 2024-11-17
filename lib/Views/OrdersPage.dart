// import 'package:flutter/material.dart';
// import 'package:khedme/Services/booking_service.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart'; // For token retrieval

// class OrdersPage extends StatelessWidget {
//   const OrdersPage({super.key});

//   // Method to retrieve token from SharedPreferences
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   // Fetch orders with the retrieved token
//   Future<List<String>> fetchOrders() async {
//     String? token = await getToken(); // Retrieve token here

//     if (token == null) {
//       throw Exception('Token not found, please login again.');
//     }

//     final response = await BookingService().getBookings(token); // Your service instance

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body); // Decode the JSON here

//       return data.map((order) {
//         return 'Order #${order['id']}: ${order['service_id']} - ${order['status']}';
//       }).toList();
//     } else {
//       throw Exception('Failed to load orders');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order History'),
//         backgroundColor: const Color(0xFF22323F), // Black blue color
//       ),
//       body: FutureBuilder<List<String>>(
//         future: fetchOrders(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No orders found.'));
//           } else {
//             final orders = snapshot.data!;
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(orders[index]),
//                   leading: const Icon(Icons.history),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
