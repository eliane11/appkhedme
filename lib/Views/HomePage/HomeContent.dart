// import 'package:flutter/material.dart';
// import 'package:khedme/Models/Worker.dart';
// import 'WorkerCard.dart';

// class HomeContent extends StatelessWidget {
//   final List<KhedmeWorker> workers;
//   final void Function(String) onCategorySelected;

//   const HomeContent({super.key, required this.workers, required this.onCategorySelected});

//   @override
//   Widget build(BuildContext context) {
//     final categories = ['All', 'Plumbing', 'Electrical', 'Carpentry'];

//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8.0),
//           color: Colors.blue,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: categories.map((category) {
//               return ElevatedButton(
//                 onPressed: () => onCategorySelected(category),
//                 child: Text(category),
//               );
//             }).toList(),
//           ),
//         ),
//         Expanded(
//           child: GridView.builder(
//             padding: const EdgeInsets.all(8.0),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: workers.length,
//             itemBuilder: (context, index) {
//               return WorkerCard(worker: workers[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
