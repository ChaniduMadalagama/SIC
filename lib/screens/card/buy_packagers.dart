import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sic/components/custem_button.dart';

class BuyPackagePage extends StatefulWidget {
  final String packageID;
  final Map<String, dynamic> userData;

  const BuyPackagePage({
    Key? key,
    required this.packageID,
    required this.userData,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BuyPackagePageState createState() => _BuyPackagePageState();
}

class _BuyPackagePageState extends State<BuyPackagePage> {
  bool _isLoading = false;
  String? verificationDocUrl;

  Future<void> _selectAndUploadVerificationDoc() async {
    setState(() {
      _isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await _uploadVerificationDoc(file);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _uploadVerificationDoc(File file) async {
    try {
      Dio dio = Dio();
      String fileName = 'verification_doc.jpg';

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/mobileupload',
        data: formData,
      );

      setState(() {
        verificationDocUrl = response.data['image_url'];
      });
    } catch (e) {
      print('Error uploading verification doc: $e');
    }
  }

  Future<void> _buyPackage() async {
    setState(() {
      _isLoading = true;
    });

    if (verificationDocUrl != null) {
      try {
        Dio dio = Dio();
        Map<String, dynamic> requestBody = {
          'package': widget.packageID,
          'user_id': widget.userData['id'],
          'payment_method': widget.userData['user_currency_type'],
          'tr_verification_doc': verificationDocUrl,
        };

        Response buyPackageResponse = await dio.post(
          'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/buypackage',
          data: jsonEncode(requestBody),
        );

        print('Buy Package Response: ${buyPackageResponse.data}');

        if (buyPackageResponse.statusCode == 200) {
          // Show success popup
          _showSuccessPopup();
        }
      } catch (e) {
        print('Error buying package: $e');
      }
    } else {
      print(
          'Please upload the verification document before buying the package.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('purchase Success'),
          content: const Text('Your purchase will activate within 74 hours.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
          'Buy Packages',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Stack(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please pay the package price to the following account numbers or pay via crypto to Binance wallet:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bank Details:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Account Name: Your Account Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Account Number: Your Account Number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Crypto Details:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Binance Wallet Address: Your Binance Wallet Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _selectAndUploadVerificationDoc,
                  child: const Text('Select and Upload Verification Doc'),
                ),
                const SizedBox(height: 20),
                CustemButton(
                  onTap: _buyPackage,
                  text: 'Buy Package',
                ),
              ],
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SpinKitWave(
                    color: Color(0xffffb100),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
