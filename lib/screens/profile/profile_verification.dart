import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sic/components/custem_button.dart';

class FileUploadPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FileUploadPage({Key? key, required this.userData}) : super(key: key);

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  List<String?> uploadedFileUrls = [null, null, null];
  bool isFile0Loading = false;
  bool isFile1Loading = false;
  bool isVerifyLoading = false;
  bool isUserVerified = false;

  @override
  void initState() {
    super.initState();
    _loadVerificationStatus(); // Load the verification status on initialization
  }

  // Load verification status from shared preferences
  Future<void> _loadVerificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserVerified = prefs.getBool('userVerified') ?? false;
    });
  }

  // Save verification status to shared preferences
  Future<void> _saveVerificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userVerified', true);
  }

  // Future<void> _selectFile(int index) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     try {
  //       // Set general loading state for the page
  //       setState(() {
  //         isFile0Loading = index == 0;
  //         isFile1Loading = index == 1;
  //       });

  //       await _uploadFile(index, File(result.files.single.path!));
  //     } catch (e) {
  //       print('Error: $e');
  //       _showErrorPopup(
  //           'An error occurred during file upload. Please try again.');
  //     } finally {
  //       // Reset general loading state for the page after upload or error
  //       setState(() {
  //         isFile0Loading = false;
  //         isFile1Loading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _selectFile(int index) async {
    if (isUserVerified) {
      // User is already verified, don't allow file upload
      _showErrorPopup('You are already verified. File upload is disabled.');
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      try {
        // Set general loading state for the page
        setState(() {
          isFile0Loading = index == 0;
          isFile1Loading = index == 1;
        });

        await _uploadFile(index, File(result.files.single.path!));
      } catch (e) {
        print('Error: $e');
        _showErrorPopup(
            'An error occurred during file upload. Please try again.');
      } finally {
        // Reset general loading state for the page after upload or error
        setState(() {
          isFile0Loading = false;
          isFile1Loading = false;
        });
      }
    }
  }

  void _showSuccessPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
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
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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
        'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/mobileupload',
        data: formData,
      );

      print('File $index uploaded. Response: ${response.data}');

      // Show success popup for file upload
      _showSuccessPopup('File $index uploaded successfully!');

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
      _showErrorPopup(
          'An error occurred during file upload. Please try again.');
    }
  }

  Future<void> _verifyUser() async {
    try {
      // Set loading state for the verify button
      setState(() {
        isVerifyLoading = true;
      });

      if (uploadedFileUrls.every((url) => url != null)) {
        Map<String, dynamic> requestBody = {
          'id': widget.userData['id'],
          'verification_doc_one': uploadedFileUrls[0],
          'verification_doc_two': uploadedFileUrls[1],
          'verification_doc_three': uploadedFileUrls[2],
        };

        Dio dio = Dio();
        Response apiResponse = await dio.post(
          'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/mobileappuserverify',
          data: jsonEncode(requestBody),
        );

        print('API response: ${apiResponse.data}');

        // Show success popup for user verification
        _showSuccessPopup('User verified successfully!');

        // Update the verification status and save it to shared preferences
        setState(() {
          isUserVerified = true;
        });
        await _saveVerificationStatus();
      } else {
        _showErrorPopup(
            'Please upload all three files before verifying the user.');
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
      _showErrorPopup(
          'An error occurred during verification. Please try again.');
    }
  }

  ElevatedButton _fileSelectButton(int index) {
    return ElevatedButton(
      onPressed: (isFile0Loading || isFile1Loading || isUserVerified)
          ? null
          : () => _selectFile(index),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select File $index from Local Storage',
            style: const TextStyle(color: Colors.black),
          ),
          if (isFile0Loading || isFile1Loading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  // CustemButton _verifyButton() {
  //   return
  //   CustemButton(onTap: () {
  //     (isVerifyLoading || isUserVerified) ? null : _verifyUser
  //   } , text: 'text');
  //   // ElevatedButton(
  //   //   onPressed: (isVerifyLoading || isUserVerified) ? null : _verifyUser,
  //   //   child: Row(
  //   //     mainAxisSize: MainAxisSize.min,
  //   //     children: [
  //   //       const Text('Verify User'),
  //   //       if (isVerifyLoading)
  //   //         const Padding(
  //   //           padding: EdgeInsets.only(left: 8.0),
  //   //           child: CircularProgressIndicator(),
  //   //         ),
  //   //     ],
  //   //   ),
  //   // );
  // }
  CustemButton _verifyButton() {
    return CustemButton(
      onTap: () {
        if (!(isVerifyLoading || isUserVerified)) {
          _verifyUser();
        }
      },
      text: 'Verify User',
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
              for (int i = 0; i < 3; i++) ...[
                if (!isUserVerified) // Show file upload buttons only if the user is not verified
                  const SizedBox(height: 20),
                _fileSelectButton(i),
              ],
              if (!isUserVerified) // Show verify button only if the user is not verified
                const SizedBox(height: 20),
              _verifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
