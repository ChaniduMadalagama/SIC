import 'package:flutter/material.dart';
import 'package:sic/screens/auth/login_page/login.dart';

class SicSplashScreen extends StatefulWidget {
  const SicSplashScreen({Key? key}) : super(key: key);

  @override
  State<SicSplashScreen> createState() => _SicSplashScreenState();
}

class _SicSplashScreenState extends State<SicSplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SicLoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // You can add an Image widget here if you want to display the logo.
        // Example:
        child: Image.asset(
          'assets/images/loginlogo.png',
          scale: 4,
        ),
      ),
    );
  }
}
