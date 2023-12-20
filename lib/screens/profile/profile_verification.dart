import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const FileUploadPage({super.key, required this.userData});
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  List<String?> uploadedFileUrls = [
    null,
    null
  ]; // For storing uploaded file URLs

  Future<void> _selectFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      await _uploadFile(index, File(result.files.single.path!));
    }
  }

  Future<void> _uploadFile(int index, File file) async {
    try {
      // Initialize Dio
      Dio dio = Dio();

      // Upload PDF file to the API
      String fileName = 'file$index.pdf';
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

      // Handle the response as needed
      print('File $index uploaded. Response: ${response.data}');

      // Update the uploaded file URL
      setState(() {
        uploadedFileUrls[index] = response.data['image_url'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _verifyUser() async {
    try {
      // Check if both files are uploaded
      if (uploadedFileUrls[0] != null && uploadedFileUrls[1] != null) {
        // Construct the body for the second API
        Map<String, dynamic> requestBody = {
          'id': widget.userData['id'],
          'verification_doc_one': uploadedFileUrls[0],
          'verification_doc_two': uploadedFileUrls[1],
        };

        // Send the second API request
        Dio dio = Dio();
        Response secondApiResponse = await dio.post(
          'https://sis-web-staging.onrender.com/api/v1/mobileapi/app/mobileappuserverify',
          data: jsonEncode(requestBody),
        );

        // Handle the response as needed
        print('Second API response: ${secondApiResponse.data}');
      } else {
        print('Please upload both files before verifying the user.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++)
              ElevatedButton(
                onPressed: () => _selectFile(i),
                child: Text('Select File $i from Local Storage'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyUser,
              child: Text('Verify User'),
            ),
          ],
        ),
      ),
    );
  }
}
