import 'package:flutter/material.dart';
import 'package:sic/screens/home/recent_activetys.dart';

class SicTransAtions extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SicTransAtions({
    super.key,
    required this.userData,
  });

  @override
  State<SicTransAtions> createState() => _SicTransAtionsState();
}

class _SicTransAtionsState extends State<SicTransAtions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RecentActivityWidget(userId: widget.userData['id']),
    );
  }
}
