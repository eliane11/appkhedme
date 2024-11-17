import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchControllerX extends GetxController {
  // Define a TextEditingController for managing the search query
  final TextEditingController searchQueryController = TextEditingController();

  // Define an observable list to hold the search results
  var searchResults = <String>[].obs;

  // Method to update the search query
  void updateSearchQuery(String query) {
    // Logic to update search results based on the query
    searchResults.value = _performSearch(query);
  }

  // Dummy search function
  List<String> _performSearch(String query) {
    // Replace with actual search logic, this is just a placeholder
    if (query.isEmpty) {
      return [];
    }
    // Example data for testing
    List<String> allResults = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
    return allResults.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
