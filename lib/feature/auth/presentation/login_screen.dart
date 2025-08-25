

import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/common/constants/app_color.dart';
import 'package:vivu_mobile/core/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  void _loginPressed(){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: Column(
          children:  [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(60),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: MAIN_LINEAR,
                ),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/icons/vivu_logo.png', // Replace with your logo asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32,),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo

                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Email field
                    _InputField(
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    _InputField(
                      hintText: 'Mật khẩu',
                      icon: Icons.email_outlined,
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF357AF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,AppRoutes.home);
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Social buttons
                    _SocialButton(
                      color: Colors.black,
                      icon: Icons.apple,
                      text: 'Đăng nhập với Apple',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    _SocialButton(
                      color: const Color(0xFF4267B2),
                      icon: Icons.facebook,
                      text: 'Đăng nhập với Facebook',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const _InputField({
    required this.hintText,
    required this.icon,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
