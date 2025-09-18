import 'package:flutter/material.dart';
import 'package:vivu_mobile/feature/auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // đảm bảo chiếm toàn bộ màn hình
        child: Image.asset(
          "assets/banners/splash_art.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}