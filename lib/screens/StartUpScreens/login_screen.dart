import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nikeshoes/screens/StartUpScreens/signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Log in to your account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7D7D7D),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFF76B1C),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildGradientButton(
                  text: 'Sign in',
                  onPressed: () {
                    // Handle sign in
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Color(0xFF7D7D7D)),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSocialLoginButtons(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Color(0xFF7D7D7D)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFFF76B1C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePasswordVisibility,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(
            icon,
            color: const Color(0xFFAAAAAA),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword ? obscureText : false,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                border: InputBorder.none,
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFFAAAAAA),
                size: 20,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAD961), Color(0xFFF76B1C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF76B1C).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Image.asset('assets/images/google_icon.png',
              width: 24, height: 24),
          onPressed: () {
            // Handle Google sign in
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: const Icon(
            Icons.facebook,
            color: Color(0xFF4267B2),
            size: 24,
          ),
          onPressed: () {
            // Handle Facebook sign in
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: const Icon(
            FontAwesomeIcons.twitter,
            color: Color(0xFF1DA1F2),
            size: 24,
          ),
          onPressed: () {
            // Handle Twitter sign in
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
