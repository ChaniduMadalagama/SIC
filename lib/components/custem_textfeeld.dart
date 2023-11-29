import 'package:flutter/material.dart';

class CustemTextfield extends StatelessWidget {
  const CustemTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isobscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isobscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isobscureText,
      decoration: InputDecoration(
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
            fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.purple),
        ),
      ),
    );
  }
}
