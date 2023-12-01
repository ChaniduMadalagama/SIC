import 'package:flutter/material.dart';

class SicCard extends StatefulWidget {
  const SicCard({super.key});

  @override
  State<SicCard> createState() => _SicCardState();
}

class _SicCardState extends State<SicCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Card"),
    );
  }
}
