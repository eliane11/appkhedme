import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'package:khedme/Models/Worker.dart';

class WorkerService extends ApiService {
  @override
  Future<List<KhedmeWorker>> fetchWorkers() async {
    try {
      final response = await http.get(buildUrl("/workers"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<KhedmeWorker> workers = data.map((worker) => KhedmeWorker.fromJson(worker)).toList();
        return workers;
      } else {
        throw Exception('Failed to load workers. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching workers: $error');
      throw Exception('Error fetching workers');
    }
  }}