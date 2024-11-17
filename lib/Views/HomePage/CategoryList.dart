import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildCategoryItem('Plumbing', Icons.plumbing),
          buildCategoryItem('Housekeeping', Icons.cleaning_services),
          buildCategoryItem('Electrical', Icons.cable),
          buildCategoryItem('Garbage Pickup', Icons.recycling),
          buildCategoryItem('Laundry', Icons.local_laundry_service),
          buildCategoryItem('Personal Trainer', Icons.directions_walk),
        ],
      ),
    );
  }

  Widget buildCategoryItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => onCategorySelected(title),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFF2AB0C3),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
