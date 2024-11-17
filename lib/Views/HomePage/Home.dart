import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Models/Worker.dart';
import 'package:khedme/Services/api_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:khedme/Views/AboutUsPage.dart';
import 'package:khedme/Views/ProfilePage.dart';
import 'package:khedme/Views/workers_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  List<KhedmeWorker> workers = [];
  int _selectedIndex = 0;
  bool _showAboutUs = false;
  bool _showProfile = false;

  final List<Map<String, String>> services = [
    {'name': 'Gardening', 'image': 'assets/images/gardening.png'},
    {'name': 'Plumber', 'image': 'assets/images/plumbing.png'},
    {'name': 'HVAC Technician', 'image': 'assets/images/electrical.png'},
    {'name': 'Cleaner', 'image': 'assets/images/cleaning.png'},
    {'name': 'Painter', 'image': 'assets/images/painting.png'},
    {'name': 'Pest Control', 'image': 'assets/images/pest_control.png'},
  ];

  @override
  void initState() {
    super.initState();
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        _showAboutUs = true;
        _showProfile = false;
      } else if (index == 2) {
        _showAboutUs = false;
        _showProfile = true;
      } else {
        _showAboutUs = false;
        _showProfile = false;
      }
    });
  }

  Widget _buildServiceGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //this is for debuggign.
            print('Selected Service: ${services[index]['name']}');
            Get.to(() => WorkersPage(service: services[index]['name']!));
          },
          child: Card(
            elevation: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    services[index]['image']!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        services[index]['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => WorkersPage(service: services[index]['name']!)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[800],
                    ),
                    child: const Text(
                      'See available workers',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _showAboutUs
            ? const AboutUs()
            : _showProfile
                ? const ProfilePage()  // Display ProfilePage here
                : _buildServiceGrid(),  // Default grid of services
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff3c3c3c)
            : const Color(0xffbebebe),
        buttonBackgroundColor: Colors.blueGrey[800],
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff1a1a1a)
            : const Color(0xfff1f1f1),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: changeTab,
      ),
    );
  }
}
