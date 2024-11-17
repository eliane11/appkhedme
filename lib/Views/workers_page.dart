import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Models/Worker.dart';
import 'package:khedme/Services/api_service.dart';
import 'package:khedme/Routes/AppRoute.dart';

extension MyStringExtension on String {
  String get myCapitalize => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

class WorkersPage extends StatefulWidget {
  final String service;

  const WorkersPage({Key? key, required this.service}) : super(key: key);

  @override
  _WorkersPageState createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  final ApiService apiService = ApiService();
  late Future<List<KhedmeWorker>> _workersFuture;

  @override
  void initState() {
    super.initState();
    _workersFuture = apiService.fetchWorkersByService(widget.service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.service} Workers')),
      body: FutureBuilder<List<KhedmeWorker>>(
        future: _workersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workers available'));
          } else {
            final workers = snapshot.data!;
            return ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${worker.firstName.myCapitalize} ${worker.lastName.myCapitalize}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Role: ${worker.role.myCapitalize}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              worker.rating?.toString() ?? 'Not rated',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoute.payment, arguments: worker);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Book Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
