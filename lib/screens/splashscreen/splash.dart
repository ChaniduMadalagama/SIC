import 'package:flutter/material.dart';
import 'package:sic/screens/auth/login_page/login.dart';
import 'package:sic/utils/app_colors.dart';

class SicSplashScreen extends StatefulWidget {
  const SicSplashScreen({super.key});

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
      backgroundColor: AppClors.backgroundcolor,
      body: const Center(
        child: Text(
          'LOGO',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
