import 'package:get/get.dart';

class HomeController extends GetxController {
  // Example state variables for the home page
  var selectedCategory = ''.obs;
  var featuredRestaurants = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedRestaurants();  // Fetch restaurants on page load
  }

  // Method to change selected category
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Mock method to fetch featured restaurants
  void fetchFeaturedRestaurants() {
    // You can replace this with actual API call logic
    featuredRestaurants.value = [
      {'name': 'Burger Palace', 'rating': '4.5 stars'},
      {'name': 'Sushi World', 'rating': '4.7 stars'},
    ];
  }
}
