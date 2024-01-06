import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sic/components/custem_button.dart';
import 'dart:convert';

import 'package:sic/components/custem_textfeeld.dart';

class Profilesetting extends StatefulWidget {
  final Map<String, dynamic> userData;

  const Profilesetting({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<Profilesetting> createState() => _ProfilesettingState();
}

class _ProfilesettingState extends State<Profilesetting> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _zipCodeController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userData['first_name']);
    _lastNameController =
        TextEditingController(text: widget.userData['last_name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _addressController =
        TextEditingController(text: widget.userData['address']);
    _cityController = TextEditingController(text: widget.userData['city']);
    _countryController =
        TextEditingController(text: widget.userData['country']);
    _zipCodeController =
        TextEditingController(text: widget.userData['zip_code']);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Profile setting',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustemTextfield(
                controller: _firstNameController,
                hintText: widget.userData['first_name'],
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _lastNameController,
                hintText: 'Last Name',
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _addressController,
                hintText: 'Address',
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _cityController,
                hintText: 'City',
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _countryController,
                hintText: 'Country',
              ),
              const SizedBox(
                height: 10,
              ),
              CustemTextfield(
                controller: _zipCodeController,
                hintText: 'Zip Code',
              ),

              // Add Update button
              // ElevatedButton(
              //   onPressed: _isLoading ? null : () => updateProfile(context),
              //   child: _isLoading
              //       ?  const SpinKitWave(
              //     color: Color(0xffffb100),
              //   )
              //       : const Text('Update'),
              // ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => updateProfile(context),
                  style: ElevatedButton.styleFrom(
                    primary: _isLoading ? Colors.grey : Color(0xffffb100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SpinKitWave(
                          color: Color(0xffffb100),
                        )
                      : const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl =
        'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/updatemobileappuser';
    final Map<String, dynamic> requestBody = {
      "id": widget.userData['id'],
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "city": _cityController.text,
      "country": _countryController.text,
      "zip_code": _zipCodeController.text,
    };

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Update successful, handle the response accordingly
        _showSuccessDialog(response.body);
      } else {
        // Update failed, handle the response accordingly
        _showErrorDialog(response.body);
      }
    } catch (error) {
      // Handle any exception that might occur during the API call
      _showErrorDialog('Error updating profile: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Successful'),
          //content: Text(message),
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Failed'),
          //content: Text(message),
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
}
