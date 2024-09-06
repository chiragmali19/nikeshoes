import 'package:flutter/material.dart';
import 'package:nikeshoes/homepage.dart'; // Make sure to import the second page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
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
              Column(
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
                    MaterialPageRoute(builder: (context) => ShoeProductsPage()),
                  );
                },
                child: Container(
                  height: 200, // Increased height for the orange area
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withOpacity(0.0),
                        Colors.orange,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
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
