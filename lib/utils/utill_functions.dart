import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  //logout
  static void logout(BuildContext context) {
    // TODO: Implement logic to clear authentication tokens or user session information

    // Close the app after logout
    SystemNavigator.pop();
  }
}
