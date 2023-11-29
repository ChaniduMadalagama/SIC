import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemText extends StatelessWidget {
  const CustemText({
     required this.text,
    this.fontsize = 30,
    this.fontWeight = FontWeight.w600,
    required this.color,
    this.textalign = TextAlign.center,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontsize;
  final FontWeight? fontWeight;
  final Color color;
  final TextAlign textalign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
      textAlign: textalign,
    );
  }
}