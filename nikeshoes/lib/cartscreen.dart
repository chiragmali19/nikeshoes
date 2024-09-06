import 'package:flutter/material.dart';

class AddToCartPage extends StatefulWidget {
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  // Default image to show initially
  String _selectedImage = 'assets/images/color2.png';
  String _selectedColor =
      'assets/images/color2.png'; // Track the selected color

  void _updateImage(String imagePath) {
    setState(() {
      _selectedImage = imagePath;
      _selectedColor = imagePath; // Update the selected color image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section (Back button, Title, Cart Icon)
              Padding(
                padding: const EdgeInsets.only(right: 28, top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0, // remove elevation
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    Text(
                      'Men\'s Shoes',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.shopping_bag_outlined, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Shoe Image with Slider
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _showLargerImage(context, _selectedImage),
                      child: Image.asset(
                        _selectedImage, // Show the selected image
                        height: 180,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.circle,
                        color: Colors.red, size: 20), // Dummy slider indicator
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Product Info Section
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Creter Impact',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '5.0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('(1120 Reviews)',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Taking the classic look of heritage Nike Running into a new realm, the Nike Air Max Pre-Day brings...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Select Color Section
                    Text(
                      'Select Color :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        // Color option 1
                        GestureDetector(
                          onTap: () {
                            _updateImage(
                                'assets/images/color2.png'); // Correct path
                          },
                          child: ColorOption(
                            imagePath:
                                'assets/images/color2.png', // Correct path
                            isSelected:
                                _selectedColor == 'assets/images/color2.png',
                          ),
                        ),
                        SizedBox(width: 10),
                        // Color option 2
                        GestureDetector(
                          onTap: () {
                            _updateImage(
                                'assets/images/color1.png'); // Correct path
                          },
                          child: ColorOption(
                            imagePath:
                                'assets/images/color1.png', // Correct path
                            isSelected:
                                _selectedColor == 'assets/images/color1.png',
                          ),
                        ),
                        SizedBox(width: 10),
                        // Color option 3
                        GestureDetector(
                          onTap: () {
                            _updateImage(
                                'assets/images/color3.png'); // Correct path
                          },
                          child: ColorOption(
                            imagePath:
                                'assets/images/color3.png', // Correct path
                            isSelected:
                                _selectedColor == 'assets/images/color3.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Size Selection Section
                    Text(
                      'Size :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizeOption(size: '40', isSelected: false),
                        SizeOption(size: '41', isSelected: false),
                        SizeOption(
                            size: '42', isSelected: true), // Selected size
                        SizeOption(size: '43', isSelected: false),
                        SizeOption(size: '44', isSelected: false),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Price and Add to Bag Section
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 22),
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Text(
                                '\$99.56',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 94, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  // Add to bag action
                                },
                                child: Text(
                                  'Add to Bag',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLargerImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust width as needed
            height: MediaQuery.of(context).size.height *
                0.6, // Adjust height as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorOption extends StatelessWidget {
  final String imagePath;
  final bool isSelected;

  const ColorOption({
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.orange : Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imagePath,
        height: 50,
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String size;
  final bool isSelected;

  const SizeOption({required this.size, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
