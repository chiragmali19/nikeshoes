import 'package:flutter/material.dart';
import 'package:nikeshoes/cartscreen.dart';

class ShoeProductsPage extends StatefulWidget {
  @override
  _ShoeProductsPageState createState() => _ShoeProductsPageState();
}

class _ShoeProductsPageState extends State<ShoeProductsPage> {
  String _selectedCategory = 'Lifestyle'; // Default selected category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, color: Colors.black),
                    Icon(Icons.search, color: Colors.black)
                  ],
                ),
              ),
              SizedBox(height: 10),
              // New Release Banner
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.orange.withOpacity(0.6)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Release',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Nike Air \nMax 90',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                            child: Text('Shop Now'),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/pair.png', // Replace with actual shoe image URL
                      height: 150,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Category Section with Horizontal Scroll
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 60, // Adjust height as needed
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryChip('Lifestyle',
                          imagePath: 'assets/images/shoe1.png',
                          isSelected: _selectedCategory == 'Lifestyle',
                          onTap: () {
                        setState(() {
                          _selectedCategory = 'Lifestyle';
                        });
                      }),
                      SizedBox(width: 16), // Spacing between chips
                      CategoryChip('Basketball',
                          imagePath: 'assets/images/shoe2.png',
                          isSelected: _selectedCategory == 'Basketball',
                          onTap: () {
                        setState(() {
                          _selectedCategory = 'Basketball';
                        });
                      }),
                      SizedBox(width: 16), // Spacing between chips
                      CategoryChip('Running',
                          imagePath: 'assets/images/color1.png',
                          isSelected: _selectedCategory == 'Running',
                          onTap: () {
                        setState(() {
                          _selectedCategory = 'Running';
                        });
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // New Men's Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Men\'s',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('See all', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Shoes Grid Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap:
                      true, // Ensure GridView doesn't take up infinite space
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: 4, // Update with actual number of shoes
                  itemBuilder: (context, index) {
                    return ShoeCard();
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip(this.label,
      {required this.imagePath, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: isSelected ? 3 : 1,
              blurRadius: isSelected ? 10 : 3,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 24, // Adjust size as needed
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/color2.png', // Replace with actual shoe image URL
                  height: 120, // Larger shoe image
                  fit: BoxFit.contain, // Adjusts image to fit
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Men\'s Shoes',
                      style: TextStyle(
                        color: Colors.red, // Red color for the label
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Creter Impact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$99.56',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black, // Black background for the button
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white), // White "+" icon
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddToCartPage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
