import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Controllers/LoginController.dart';
import 'package:khedme/Routes/AppRoute.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logbackground.png'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5), // half opacity overlay
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // App logo
                  Container(
                    height: 250,
                    width: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'), // Logo image
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // White color for better contrast
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7), // Hint text color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2), // Text field background color
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white), // Input text color
                  ),
                  const SizedBox(height: 20),

                  // Password field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // White color for better contrast
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded corners
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7), // Hint text color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2), // Text field background color
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white), // Input text color
                  ),
                  const SizedBox(height: 30),
                  
                  // Login and Register buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.login(); // Replace with your login logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, // Button color
                          foregroundColor: Colors.white, // Text color
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), //Rounded button
                          ),
                        ),
                        child: const Text("Login"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.register); //go to Register page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, //button color
                          foregroundColor: Colors.white, //text color
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), //rouunded button
                          ),
                        ),
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
