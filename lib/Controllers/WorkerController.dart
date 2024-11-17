// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:khedme/Services/ApiService.dart';
// import 'package:shared_preferences/shared_preferences.dart';  // To manage token storage

// class WorkerController extends GetxController {
//   var workers = [].obs;  // Observable list to hold worker data
//   var isLoading = true.obs;  // Observable boolean for loading state
//   var errorMessage = ''.obs;  // Observable for error message

//   @override
//   void onInit() {
//     super.onInit();
//     fetchWorkers();  // Fetch workers when controller is initialized
//   }

//   Future<void> fetchWorkers() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     // Retrieve token from SharedPreferences
//     String? token = await _getToken();

//     if (token == null) {
//       errorMessage.value = "Token is missing, please log in.";
//       isLoading.value = false;
//       return;
//     }

//     try {
//       ApiService apiService = ApiService();
//       var response = await apiService.getWorkers(token);

//       if (response.statusCode == 200) {
//         workers.value = jsonDecode(response.body);  // Update the worker list
//       } else {
//         errorMessage.value = "Failed to fetch workers. Status: ${response.statusCode}";
//       }
//     } catch (e) {
//       errorMessage.value = "An error occurred while fetching workers: $e";
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Method to retrieve the token from SharedPreferences
//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }
// }
