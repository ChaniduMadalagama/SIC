import 'package:flutter/material.dart';

class UtillFunction {
  //Navigater push function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  //Navigater push function
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
