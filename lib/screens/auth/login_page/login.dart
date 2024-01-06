import 'package:flutter/material.dart';
import 'package:sic/components/custem_button.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/components/custem_textfeeld.dart';
import 'package:sic/screens/home/commen_screen.dart';
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
  bool isLoading = false; // Track the loading state

  @override
  Widget build(BuildContext context) {
    final _phonehumber = TextEditingController();
    final _password = TextEditingController();
    Future<void> loginUser(BuildContext context) async {
      // Set loading state to true when login starts
      setState(() {
        isLoading = true;
      });

      const url =
          'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/mobileuserlogin';
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
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData['status']) {
            print('Login successful');
            print(response.body);

            final Map<String, dynamic> userData = responseData['userData'];

            // ignore: use_build_context_synchronously
            UtillFunction.navigateTo(
                context, SicCommonScreen(userData: userData));
          } else {
            // Show popup for invalid credentials
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
          // Show popup for other HTTP status codes
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(
                    'Login failed with status code: ${response.statusCode}'),
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
      } catch (error) {
        print('Error during login: $error');
        // Show generic error popup
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'An error occurred during login. Please try again.'),
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
      } finally {
        // Set loading state to false when login is complete (success or failure)
        setState(() {
          isLoading = false;
        });
      }
    }

    // Future<void> loginUser(BuildContext context) async {
    //   // Set loading state to true when login starts
    //   setState(() {
    //     isLoading = true;
    //   });

    //   const url =
    //       'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/mobileuserlogin';
    //   final Map<String, dynamic> requestBody = {
    //     "user_key": "7760524e-7334-4ae6-bd3d-cd0a5ba8a09c",
    //     "phone": _phonehumber.text,
    //     "password": _password.text,
    //   };

    //   try {
    //     final response = await http.post(
    //       Uri.parse(url),
    //       body: jsonEncode(requestBody),
    //       headers: {'Content-Type': 'application/json'},
    //     );

    //     if (response.statusCode == 200) {
    //       final Map<String, dynamic> responseData = jsonDecode(response.body);

    //       if (responseData['status']) {
    //         print('Login successful');
    //         print(response.body);

    //         final Map<String, dynamic> userData = responseData['userData'];

    //         UtillFunction.navigateTo(
    //             context, SicCommonScreen(userData: userData));
    //       } else {
    //         // ignore: use_build_context_synchronously
    //         showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return AlertDialog(
    //               title: const Text('Invalid Credentials'),
    //               content: Text(responseData['message']),
    //               actions: [
    //                 TextButton(
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                   child: const Text('OK'),
    //                 ),
    //               ],
    //             );
    //           },
    //         );
    //       }
    //     } else {
    //       print('Login failed with status code: ${response.statusCode}');
    //       print(response.body);
    //     }
    //   } catch (error) {
    //     print('Error during login: $error');
    //   } finally {
    //     // Set loading state to false when login is complete (success or failure)
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
                        color: Color(0xffffb100),
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
                  print('Hi Im here');
                  loginUser(context);
                },
                text: isLoading ? 'Logging in...' : 'Login',
                isLoading: isLoading,
              ),
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
                text: 'Create new account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
