import 'package:flutter/material.dart';

class SicProfile extends StatefulWidget {
  const SicProfile({super.key});

  @override
  State<SicProfile> createState() => _SicProfileState();
}

class _SicProfileState extends State<SicProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Text('Profile'),
    );
  }
}
