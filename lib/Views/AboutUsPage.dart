import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large image on top
          SizedBox(
            width: double.infinity, //full width image
            child: Image.asset(
              'assets/images/meetus.png',
              fit: BoxFit.contain, //show entire image
              height: 350,
            ),
          ),
          const SizedBox(height: 16), // Space between the image and text
          const Text(
            'Contact Us:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black, // Changed to black for visibility
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Email: anthonybader2000@gmail.com\n'
            'Email: zaccouranthony@gmail.com\n'
            'Email: elianemsawaya@gmail.com\n'
            'Email: Samernasr1@live.com\n'
            'Email: nakouzisamia@gmail.com',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Meet the Developers:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '1. Anthony Bader\n'
            '2. Anthony Zakkour\n'
            '3. Eliane Sawaya\n'
            '4. Samer Nasr\n'
            '5. Samia Nakouzi',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
