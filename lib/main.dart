import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Routes/AppPage.dart';
import 'package:khedme/Routes/AppRoute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Khedme App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Using MaterialColor for primarySwatch
        scaffoldBackgroundColor: Colors.white, // Lighter background for the app
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900], // Darker color for the app bar
          foregroundColor: Colors.white, // White text color on the app bar
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black87,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ), // Large text
          displayMedium: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ), // Slightly smaller
          displaySmall: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ), // Header text
          bodyLarge: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ), // Main body text
          bodyMedium: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ), // Secondary body text
        ),

        cardColor: Colors.blueGrey[700], // Dark grey for cards
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoute.splash,
      getPages: AppPage.pages,
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}
