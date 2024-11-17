import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Routes/AppRoute.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background.png', // Ensure this image is in your assets
            fit: BoxFit.cover,
          ),
          // Content on top of the background
          Column(
            children: [
              // App logo
              Container(
                height: 250,
                width: 250,
                padding: const EdgeInsets.only(top: 50), // Padding to ensure logo isn't too close to top
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'), // Your logo image
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(), // Pushes the buttons to the bottom
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0), // Padding to give space at bottom
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.register);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey, // Button color
                        foregroundColor: Colors.grey[200], // Text color
                        minimumSize: const Size(double.infinity, 50), // Full-width button
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey, // Button color
                        foregroundColor: Colors.grey[200], // Text color
                        minimumSize: const Size(double.infinity, 50), // Full-width button
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
