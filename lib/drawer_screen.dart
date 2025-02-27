import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nikeshoes/screens/StartUpScreens/login_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String? userName = '';
  String? userEmail = '';
  String? profileImageUrl = ''; // Store the URL of the user's image
  bool isLoading = true;
  File? _image; // Store the selected image
  bool isNetworkImage = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Default image to use when no profile image is available
  final String defaultImagePath =
      'https://img.freepik.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3467.jpg';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore (For both regular and Google sign-in users)
  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Try to fetch from regular users collection first
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        setState(() {
          userName = userData?['username'] ?? user.displayName ?? 'No Name';
          userEmail = userData?['email'] ?? user.email ?? 'No Email';

          // Check if profileImageUrl exists and is not empty
          if (userData?['profileImageUrl'] != null &&
              userData!['profileImageUrl'].toString().isNotEmpty) {
            profileImageUrl = userData['profileImageUrl'];

            // Check if it's a network image (starts with http)
            if (profileImageUrl!.startsWith('http')) {
              isNetworkImage = true;
            } else {
              // It's a local file path
              isNetworkImage = false;
              try {
                // Check if the file exists
                File file = File(profileImageUrl!);
                if (!file.existsSync()) {
                  // If file doesn't exist, use default
                  profileImageUrl = defaultImagePath;
                  isNetworkImage = true;
                }
              } catch (e) {
                // If there's an error, use default
                profileImageUrl = defaultImagePath;
                isNetworkImage = true;
              }
            }
          } else {
            // No profile image URL, use default
            profileImageUrl = defaultImagePath;
            isNetworkImage = true;
          }

          isLoading = false;
        });
      } else {
        // If not found in regular users, try Google users collection
        DocumentSnapshot googleUserDoc = await FirebaseFirestore.instance
            .collection('users_with_Google')
            .doc(user.uid)
            .get();

        if (googleUserDoc.exists) {
          Map<String, dynamic>? userData =
              googleUserDoc.data() as Map<String, dynamic>?;

          setState(() {
            userName = userData?['username'] ?? user.displayName ?? 'No Name';
            userEmail = userData?['email'] ?? user.email ?? 'No Email';

            // Check if profileImageUrl exists and is not empty
            if (userData?['profileImageUrl'] != null &&
                userData!['profileImageUrl'].toString().isNotEmpty) {
              profileImageUrl = userData['profileImageUrl'];

              // Check if it's a network image (starts with http)
              if (profileImageUrl!.startsWith('http')) {
                isNetworkImage = true;
              } else {
                // It's a local file path
                isNetworkImage = false;
                try {
                  // Check if the file exists
                  File file = File(profileImageUrl!);
                  if (!file.existsSync()) {
                    // If file doesn't exist, use default
                    profileImageUrl = defaultImagePath;
                    isNetworkImage = true;
                  }
                } catch (e) {
                  // If there's an error, use default
                  profileImageUrl = defaultImagePath;
                  isNetworkImage = true;
                }
              }
            } else {
              // No profile image URL, use default
              profileImageUrl = defaultImagePath;
              isNetworkImage = true;
            }

            isLoading = false;
          });
        } else {
          // User not found in any collection
          setState(() {
            userName = user.displayName ?? 'No Name';
            userEmail = user.email ?? 'No Email';
            profileImageUrl = user.photoURL ?? defaultImagePath;
            isNetworkImage = true;
            isLoading = false;
          });
        }
      }
    } else {
      // No user is logged in
      setState(() {
        isLoading = false;
      });
    }
  }

  // Method to pick an image from the camera or gallery
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile;

    // Show options for Camera or Gallery
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image"),
          actions: [
            TextButton(
              onPressed: () async {
                pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                Navigator.pop(context);
              },
              child: const Text("Take a Photo"),
            ),
            TextButton(
              onPressed: () async {
                pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                Navigator.pop(context);
              },
              child: const Text("Pick from Gallery"),
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      String imagePath = pickedFile!.path; // Get local file path
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Check if user exists in regular users collection
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Update regular users collection
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'profileImageUrl': imagePath});
        } else {
          // Check if user exists in Google users collection
          DocumentSnapshot googleUserDoc = await FirebaseFirestore.instance
              .collection('users_with_Google')
              .doc(user.uid)
              .get();

          if (googleUserDoc.exists) {
            // Update Google users collection
            await FirebaseFirestore.instance
                .collection('users_with_Google')
                .doc(user.uid)
                .update({'profileImageUrl': imagePath});
          }
        }

        // Update the state with the new image
        setState(() {
          profileImageUrl = imagePath;
          isNetworkImage = false;
          _image = File(imagePath);
        });
      }
    }
  }

  // Log out method
  Future<void> signOut(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('User signed out');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // Delete account method
  Future<void> deleteAccount(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Show confirmation dialog
      bool confirmDelete = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Delete Account"),
                content: const Text(
                    "Are you sure you want to delete your account? This action cannot be undone."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          ) ??
          false;

      if (confirmDelete) {
        try {
          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Deleting account..."),
                  ],
                ),
              );
            },
          );

          // Check if user exists in regular users collection
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            // Delete from regular users collection
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .delete();
          } else {
            // Check if user exists in Google users collection
            DocumentSnapshot googleUserDoc = await FirebaseFirestore.instance
                .collection('users_with_Google')
                .doc(user.uid)
                .get();

            if (googleUserDoc.exists) {
              // Delete from Google users collection
              await FirebaseFirestore.instance
                  .collection('users_with_Google')
                  .doc(user.uid)
                  .delete();
            }
          }

          // Delete user from Firebase Authentication
          await user.delete();

          // Close loading dialog
          Navigator.of(context).pop();

          // Navigate to login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } catch (e) {
          // Close loading dialog
          Navigator.of(context).pop();

          // Show error dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text("Failed to delete account: ${e.toString()}"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading while fetching data
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 230,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _pickImage, // Allow user to pick an image
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: _getProfileImage(),
                            child: _buildEditOverlay(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          title: Text(userName ?? 'No Name'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(userEmail ?? 'No Email'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Logout button
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    signOut(context);
                  },
                ),
                // Delete Account button
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Delete Account',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {
                    deleteAccount(context);
                  },
                ),
              ],
            ),
    );
  }

  // Helper method to get the right image provider based on the image type
  ImageProvider _getProfileImage() {
    if (_image != null) {
      return FileImage(_image!);
    } else if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      if (isNetworkImage) {
        return NetworkImage(profileImageUrl!);
      } else {
        try {
          File file = File(profileImageUrl!);
          if (file.existsSync()) {
            return FileImage(file);
          } else {
            return NetworkImage(defaultImagePath);
          }
        } catch (e) {
          return NetworkImage(defaultImagePath);
        }
      }
    } else {
      return NetworkImage(defaultImagePath);
    }
  }

  // Add a small edit icon overlay to the profile image
  Widget? _buildEditOverlay() {
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return null; // Hide the edit icon if user has a profile image
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.edit,
            color: Colors.orange,
            size: 16,
          ),
        ),
      ],
    );
  }
}
