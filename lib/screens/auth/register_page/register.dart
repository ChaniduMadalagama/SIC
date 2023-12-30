import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sic/components/custem_button.dart';
import 'package:sic/components/custem_textfeeld.dart';
import 'package:sic/components/custemdropdown.dart';
import 'package:sic/utils/utill_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SicRegister extends StatefulWidget {
  const SicRegister({Key? key}) : super(key: key);

  @override
  State<SicRegister> createState() => _SicRegisterState();
}

class _SicRegisterState extends State<SicRegister> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformpassword = TextEditingController();
  TextEditingController referralcode = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isobscureText = false;
  int selectedCurrencyType = 0;

  @override
  void initState() {
    super.initState();
    // Additional initialization if needed
  }

  Future<void> registerUser() async {
    const url =
        'https://sis-web-staging.onrender.com/api/v1/mobileapi/app/saveappuser';
    final Map<String, dynamic> requestBody = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": email.text,
      "phone": phoneNumber.text,
      "address": address.text,
      "city": city.text,
      "country": country.text,
      "zip_code": zipCode.text,
      "password": password.text,
      "user_currency_type": selectedCurrencyType,
      "referral_code": referralcode.text
    };

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        // Successful registration
        print('Registration successful');
        print(response.body);

        // Show success popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Successful'),
              content:
                  const Text('Your account has been successfully registered.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear text fields
        firstName.clear();
        lastName.clear();
        email.clear();
        phoneNumber.clear();
        address.clear();
        city.clear();
        country.clear();
        zipCode.clear();
        password.clear();
        conformpassword.clear();
        referralcode.clear();
      } else {
        // Handle registration failure
        print('Registration failed with status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      // Handle any errors during the HTTP request
      print('Error during registration: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 73),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        color: const Color(0xffD3F570),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'Create an account so you can explore all the\nexisting jobs',
                      style: TextStyle(
                        color: const Color(0xffFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              CustemTextfield(
                controller: firstName,
                hintText: 'First Name',
              ),
              const SizedBox(height: 26),
              CustemTextfield(
                controller: lastName,
                hintText: 'Last Name',
              ),
              const SizedBox(height: 26),
              CustemTextfield(
                controller: email,
                hintText: 'Email',
              ),
              const SizedBox(height: 26),
              IntlPhoneField(
                controller: phoneNumber,
                focusNode: focusNode,
                obscureText: isobscureText,
                decoration: InputDecoration(
                  counterText: null,
                  counterStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                ),
                languageCode: "en",
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  // print('Country changed to: ' + country.name);
                },
              ),
              const SizedBox(height: 20),
              CustemTextfield(
                controller: address,
                hintText: 'Address',
              ),
              const SizedBox(height: 29),
              CustemTextfield(
                controller: city,
                hintText: 'City',
              ),
              const SizedBox(height: 29),
              CustemTextfield(
                controller: country,
                hintText: 'Country',
              ),
              const SizedBox(height: 29),
              CustemDropdown(
                value: selectedCurrencyType,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCurrencyType = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 29),
              CustemTextfield(
                controller: zipCode,
                hintText: 'Zip Code',
              ),
              const SizedBox(height: 29),
              CustemTextfield(
                controller: referralcode,
                hintText: 'Referral Code',
              ),
              const SizedBox(height: 29),
              CustemTextfield(
                controller: password,
                hintText: 'Password',
                isobscureText: true,
              ),
              const SizedBox(height: 30),
              CustemTextfield(
                controller: conformpassword,
                hintText: 'Confirm Password',
                isobscureText: true,
              ),
              const SizedBox(height: 30),
              CustemButton(
                onTap: () {
                  registerUser();
                  print('Test');
                },
                text: 'Sign up',
              ),
              const SizedBox(height: 30),
              CustemButton(
                textcolor: Colors.black,
                height: 40,
                fontsize: 14,
                color: Colors.white,
                onTap: () {
                  UtillFunction.goBack(context);
                },
                text: 'Already have an account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
