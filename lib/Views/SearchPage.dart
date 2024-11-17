import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Controllers/SearchControllerX.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the instance of SearchControllerX using Get.find()
    final SearchControllerX searchController = Get.find<SearchControllerX>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color(0xFF22323F), // Black blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // Use the searchController instance here
              controller: searchController.searchQueryController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              // Use the updateSearchQuery method from the searchController instance
              onChanged: searchController.updateSearchQuery,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                // Handle the search results
                if (searchController.searchResults.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }
                return ListView.builder(
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (context, index) {
                    final result = searchController.searchResults[index];
                    return ListTile(
                      title: Text(result),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
