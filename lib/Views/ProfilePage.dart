import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';  // To get the logged-in user data

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String name = '';
  late String email = '';
  late String phoneNumber = '';
  late String address = '';
  late String degrees = '';
  late String cv = '';
  late String id = '';
  late String otherInfo = '';
  late String userId = '';  // Variable to store the logged-in user's ID

  @override
  void initState() {
    super.initState();
    _getUserId();  // Fetch the logged-in user ID
  }

  // Fetch logged-in user's ID from shared preferences (or any other method)
  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');  // Assuming the user ID is saved under 'userId'
    if (userId != null) {
      setState(() {
        this.userId = userId;
      });
      fetchUserData();  // Fetch user data once the user ID is retrieved
    } else {
      // Handle the case where the user ID is not found (maybe navigate to login page)
      showErrorSnackbar('User not logged in.');
    }
  }

  // Fetch user data from the database
  Future<void> fetchUserData() async {
    if (userId.isEmpty) return;

    try {
      final response = await http.get(
        Uri.parse('https://localhost:8000/api/users/$userId'),
      );

      // Print the response body for debugging
      print('Response body: ${response.body}');  // Debugging line

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('User Data: $data');  // Debugging line

        setState(() {
          name = data['first_name'] + ' ' + data['last_name'];
          email = data['email'] ?? '';
          phoneNumber = data['phone'] ?? '';
          address = data['address'] ?? '';
        });
      } else {
        showErrorSnackbar('Failed to load user data. Please try again later.');
      }
    } catch (error) {
      // Catching network or unexpected errors
      showErrorSnackbar('An unexpected error occurred. Please try again later.');
      print('Error: $error');
    }
  }

  // Display an error message in a snackbar
  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Show dialog for applying to be a worker
  void _showApplyToBeWorkerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apply to be a Worker'),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('Degrees', (value) => degrees = value!, true),
                  _buildTextField('CV', (value) => cv = value!, true),
                  _buildTextField('ID', (value) => id = value!, false),
                  _buildTextField('Other Information', (value) => otherInfo = value!, false),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop();
                  _showConfirmationDialog("Application submitted successfully!");
                }
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, FormFieldSetter<String> onSaved, bool isRequired) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      onSaved: onSaved,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Display user information (Non-editable)
  Widget _buildProfileInfo(String label, String value, bool isReadOnly) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Show confirmation dialog after submission
  void _showConfirmationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered Profile Text
              const SizedBox(height: 50),  // Adjust the space for better positioning
              Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Picture (Replace image with an icon)
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blueGrey,  // Placeholder color
                      child: Icon(Icons.person, size: 50, color: Colors.white),  // Placeholder icon
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: () {
                        // Handle image selection
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Display user information (Non-editable)
              _buildProfileInfo("Name", name, true),
              _buildProfileInfo("Email", email, true),
              _buildProfileInfo("Phone Number", phoneNumber, true),
              _buildProfileInfo("Address", address, false),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showApplyToBeWorkerDialog();
                },
                child: const Text('Apply to be a Worker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
