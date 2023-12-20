import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuyPackagePage extends StatefulWidget {
  const BuyPackagePage({
    Key? key,
  }) : super(key: key);

  @override
  _BuyPackagePageState createState() => _BuyPackagePageState();
}

class _BuyPackagePageState extends State<BuyPackagePage> {
  String? verificationDocUrl;

  Future<void> _selectAndUploadVerificationDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await _uploadVerificationDoc(file);
    }
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
        'https://sis-web-staging.onrender.com/api/v1/mobileapi/mobileupload',
        data: formData,
      );
      print(response.data);
      setState(() {
        verificationDocUrl = response.data['image_url'];
      });
    } catch (e) {
      print('Error uploading verification doc: $e');
    }
  }

  Future<void> _buyPackage() async {
    if (verificationDocUrl != null) {
      try {
        Dio dio = Dio();
        Map<String, dynamic> requestBody = {
          'package': '657453e949c1fa28f4587127',
          'user_id': '6582b7d26cf99d00430b6c6a',
          'payment_method': '1',
          'tr_verification_doc': verificationDocUrl,
        };

        Response buyPackageResponse = await dio.post(
          'https://sis-web-staging.onrender.com/api/v1/mobileapi/app/buypackage',
          data: jsonEncode(requestBody),
        );

        print('Buy Package Response: ${buyPackageResponse.data}');
      } catch (e) {
        print('Error buying package: $e');
      }
    } else {
      print(
          'Please upload the verification document before buying the package.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Package'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectAndUploadVerificationDoc,
              child: Text('Select and Upload Verification Doc'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buyPackage,
              child: Text('Buy Package'),
            ),
          ],
        ),
      ),
    );
  }
}
