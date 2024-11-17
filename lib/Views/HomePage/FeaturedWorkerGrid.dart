// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:khedme/Models/Worker.dart';
// import 'WorkerCard.dart';

// class FeaturedWorkerGrid extends StatefulWidget {
//   const FeaturedWorkerGrid({super.key});

//   @override
//   _FeaturedWorkerGridState createState() => _FeaturedWorkerGridState();
// }

// class _FeaturedWorkerGridState extends State<FeaturedWorkerGrid> {
//   List<KhedmeWorker> workers = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchWorkers();
//   }

//   Future<void> fetchWorkers() async {
//     try {
//       final response = await http.get(Uri.parse('http://localhost:8000/api/users')).timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         final List<KhedmeWorker> filteredWorkers = data
//             .where((user) => user['service_type'] != null)
//             .map((user) => KhedmeWorker(
//                   name: user['name'],
//                   role: user['role'],
//                   imageUrl: 'assets/images/${user['role'].toLowerCase()}.png',
//                   category: user['service_type'] ?? 'Unknown',
//                   rating: user['rating'] != null ? double.parse(user['rating'].toString()) : 0.0,
//                   price: user['price'](),
//                 ))
//             .toList();

//         setState(() {
//           workers = filteredWorkers;
//         });
//       } else {
//         print('Failed to load workers: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error fetching workers: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return workers.isEmpty
//         ? const Center(child: CircularProgressIndicator())
//         : GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: workers.length,
//             itemBuilder: (context, index) {
//               return WorkerCard(worker: workers[index]);
//             },
//           );
//   }
// }
