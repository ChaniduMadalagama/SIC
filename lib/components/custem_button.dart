import 'package:flutter/material.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/utils/app_colors.dart';

class CustemButton extends StatelessWidget {
  const CustemButton({
    required this.onTap,
    required this.text,
    this.height = 50,
    this.fontsize = 18,
    this.color,
    this.textcolor,
    this.isLoading = false, // New parameter for loading state
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final double height;
  final double fontsize;
  final Color? color;
  final Color? textcolor;
  final bool isLoading; // New parameter for loading state

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppClors.buttoncolor;
    final textColorValue = textcolor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Center(
                child: CustemText(
                  text: text,
                  fontsize: fontsize,
                  color: textColorValue,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
