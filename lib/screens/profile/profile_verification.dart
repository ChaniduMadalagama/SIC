import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FileUploadPage({Key? key, required this.userData}) : super(key: key);

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  List<String?> uploadedFileUrls = [null, null];
  bool isFile0Loading = false;
  bool isFile1Loading = false;
  bool isVerifyLoading = false;

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
      // Set loading state for the specific button
      setState(() {
        if (index == 0) {
          isFile0Loading = true;
        } else {
          isFile1Loading = true;
        }
      });

      Dio dio = Dio();
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

      print('File $index uploaded. Response: ${response.data}');

      setState(() {
        uploadedFileUrls[index] = response.data['image_url'];
        // Reset loading state for the specific button
        if (index == 0) {
          isFile0Loading = false;
        } else {
          isFile1Loading = false;
        }
      });
    } catch (e) {
      // Reset loading state for the specific button in case of an error
      setState(() {
        if (index == 0) {
          isFile0Loading = false;
        } else {
          isFile1Loading = false;
        }
      });
      print('Error: $e');
    }
  }

  Future<void> _verifyUser() async {
    try {
      // Set loading state for the verify button
      setState(() {
        isVerifyLoading = true;
      });

      if (uploadedFileUrls[0] != null && uploadedFileUrls[1] != null) {
        Map<String, dynamic> requestBody = {
          'id': widget.userData['id'],
          'verification_doc_one': uploadedFileUrls[0],
          'verification_doc_two': uploadedFileUrls[1],
        };

        Dio dio = Dio();
        Response secondApiResponse = await dio.post(
          'https://sis-web-staging.onrender.com/api/v1/mobileapi/app/mobileappuserverify',
          data: jsonEncode(requestBody),
        );

        print('Second API response: ${secondApiResponse.data}');
      } else {
        print('Please upload both files before verifying the user.');
      }

      // Reset loading state for the verify button
      setState(() {
        isVerifyLoading = false;
      });
    } catch (e) {
      // Reset loading state for the verify button in case of an error
      setState(() {
        isVerifyLoading = false;
      });
      print('Error: $e');
    }
  }

  ElevatedButton _fileSelectButton(int index) {
    return ElevatedButton(
      onPressed: index == 0
          ? (isFile0Loading ? null : () => _selectFile(index))
          : (isFile1Loading ? null : () => _selectFile(index)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select File $index from Local Storage',
            style: const TextStyle(color: Colors.amber),
          ),
          if (index == 0 && isFile0Loading || index == 1 && isFile1Loading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  ElevatedButton _verifyButton() {
    return ElevatedButton(
      onPressed: isVerifyLoading ? null : _verifyUser,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Verify User'),
          if (isVerifyLoading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
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
          'Profile verification',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To complete profile verification, please follow these steps:\n\n'
                '1. Click on "Select File 0" and choose an image of the front side of your ID card or driving license.\n\n'
                '2. Click on "Select File 1" and choose an image of the back side of your ID card or driving license.\n\n'
                '3. Once both files are selected, click on "Verify User" to submit your documents for verification.\n\n'
                'Note: Only images in PDF OR IMAGE formats are accepted.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.start,
              ),
              for (int i = 0; i < 2; i++) ...[
                const SizedBox(height: 20),
                _fileSelectButton(i),
              ],
              const SizedBox(height: 20),
              _verifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
