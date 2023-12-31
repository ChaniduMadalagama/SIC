import 'package:flutter/material.dart';
import 'package:sic/screens/auth/login_page/login.dart';
import 'package:sic/screens/splashscreen/splash.dart';
//import 'package:sic/screens/splashscreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ISC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SicSplashScreen()
        // SicLoginPage(),
        );
  }
}
