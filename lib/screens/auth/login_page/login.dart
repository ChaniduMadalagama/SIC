import 'package:flutter/material.dart';
import 'package:sic/components/custem_button.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/components/custem_textfeeld.dart';
import 'package:sic/screens/home/commen_screen.dart';
//import 'package:sic/home/home.dart';
import 'package:sic/screens/auth/register_page/register.dart';
import 'package:sic/utils/utill_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SicLoginPage extends StatefulWidget {
  const SicLoginPage({super.key});

  @override
  State<SicLoginPage> createState() => _SicLoginPageState();
}

class _SicLoginPageState extends State<SicLoginPage> {
  @override
  Widget build(BuildContext context) {
    final _phonehumber = TextEditingController();
    final _password = TextEditingController();

    Future<void> loginUser(BuildContext context) async {
      const url =
          'https://sis-web-staging.onrender.com/api/v1/mobileapi/mobileuserlogin';
      final Map<String, dynamic> requestBody = {
        "user_key": "7760524e-7334-4ae6-bd3d-cd0a5ba8a09c",
        "phone": _phonehumber.text,
        "password": _password.text,
      };

      try {
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          // Parse the JSON response
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData['status']) {
            // Successful login, handle the response accordingly
            print('Login successful');
            print(response.body);

            // Extract user data from the response
            final Map<String, dynamic> userData = responseData['userData'];

            // TODO: Pass the user data to the next page
            // For example, you can pass it as arguments when navigating to the next page
            UtillFunction.navigateTo(
                context, SicCommonScreen(userData: userData));
          } else {
            // Show a popup for invalid credentials
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Invalid Credentials'),
                  content: Text(responseData['message']),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Handle other HTTP status codes
          print('Login failed with status code: ${response.statusCode}');
          print(response.body);
        }
      } catch (error) {
        // Handle any errors during the HTTP request
        print('Error during login: $error');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 73,
              ),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Login here',
                      style: TextStyle(
                        color: Color(0xffD3F570),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Welcome back you’ve\nbeen missed!',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              CustemTextfield(
                controller: _phonehumber,
                hintText: 'Phone Number',
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: _password,
                hintText: 'Password',
                isobscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    //  UtillFunction.navigateTo(context, const FogotPassword());
                  },
                  child: const CustemText(
                    text: 'Forgot your password',
                    fontsize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  onTap: () {
                    print('Hi Im hear');
                    loginUser(context);
                    // UtillFunction.navigateTo(context, const SicCommonScreen());
                  },
                  text: 'Login'),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  textcolor: Colors.black,
                  height: 40,
                  fontsize: 14,
                  color: Colors.white,
                  onTap: () {
                    UtillFunction.navigateTo(context, const SicRegister());
                  },
                  text: 'Create new account'),
            ],
          ),
        ),
      ),
    );
  }
}
