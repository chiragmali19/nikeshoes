// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nikeshoes/homepage.dart'; // Make sure to import the second page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image covering the entire page
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/background.png', // Replace with your background image path
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Layout with shoe, text, and arrow
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Centered shoe image
              Image.asset(
                'assets/images/shoe2.png', // Replace with your shoe image path
                fit: BoxFit.contain,
              ),
              // Text between shoe and arrow
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'LIVE YOUR\nPERFECT',
                    style: TextStyle(
                      fontSize: 44, // Adjust font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Changed to white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Smart, gorgeous & fashionable \n collection makes you cool',
                    style: TextStyle(
                      fontSize: 16, // Adjust font size
                      color: Colors.white, // Changed to white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                ],
              ),
              // Get Started section with arrows
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoeProductsPage()),
                  );
                },
                child: Container(
                  height: 200, // Increased height for the orange area
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.orange.withOpacity(0.0),
                        Colors.orange,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                     // Rounded edges
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_double_arrow_up,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
