import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Controllers/RegisterController.dart';
import 'package:khedme/Validators/FormValidator.dart'; // Import the validator

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>(); // Moved inside the State class

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>(); // Access the controller

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with opacity
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/regbackground.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            ),
          ),
          // Content on top of the background
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // App logo
                    Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'), // Your logo image
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // First Name
                    _buildTextField(
                      controller: controller.firstName,
                      label: "First Name",
                      hintText: "Enter your first name",
                      validator: FormValidator.validateName, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Last Name
                    _buildTextField(
                      controller: controller.lastName,
                      label: "Last Name",
                      hintText: "Enter your last name",
                      validator: FormValidator.validateName, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Email
                    _buildTextField(
                      controller: controller.email,
                      label: "Email",
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidator.validateEmail, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Phone Number
                    _buildTextField(
                      controller: controller.phone,
                      label: "Phone Number",
                      hintText: "Enter your phone number",
                      keyboardType: TextInputType.phone,
                      validator: FormValidator.validatePhone, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Address
                    _buildTextField(
                      controller: controller.address,
                      label: "Address",
                      hintText: "Enter your address",
                      validator: FormValidator.validateAddress, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Password
                    _buildTextField(
                      controller: controller.password,
                      label: "Password",
                      hintText: "Enter your password",
                      obscureText: true,
                      validator: FormValidator.validatePassword, // Use the external validator
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    _buildTextField(
                      controller: controller.confirmPassword,
                      label: "Confirm Password",
                      hintText: "Re-enter your password",
                      obscureText: true,
                      validator: (value) {
                        if (value != controller.password.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.register().then((success) {
                              if (success) {
                                Get.snackbar('Success', 'Registration successful',
                                    snackPosition: SnackPosition.BOTTOM);
                                // Optionally navigate to the login page
                              } else {
                                Get.snackbar('Error', 'Registration failed',
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, // Button color
                          foregroundColor: Colors.white, // Text color
                          padding: const EdgeInsets.symmetric(vertical: 15), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, // Bold text
                            fontSize: 16, // Font size
                          ),
                        ),
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for building text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // Text color
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7), // Hint text color
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2), // Text field background color
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator, // Use the validator passed to the field
        ),
      ],
    );
  }
}
