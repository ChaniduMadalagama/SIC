import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sic/components/custem_button.dart';
import 'dart:convert';

import 'package:sic/components/custem_text.dart';
import 'package:sic/components/custem_textfeeld.dart';

class SicWithdrowMoney extends StatefulWidget {
  final Map<String, dynamic> userData;

  const SicWithdrowMoney({Key? key, required this.userData}) : super(key: key);

  @override
  _SicWithdrowMoneyState createState() => _SicWithdrowMoneyState();
}

class _SicWithdrowMoneyState extends State<SicWithdrowMoney> {
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController walletAddressController = TextEditingController();

  bool isLoading = false; // Variable to track loading state

  Future<Map<String, dynamic>> submitWithdrawRequest(
      String apiUrl, dynamic requestBody) async {
    try {
      final response =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requestBody));
      if (response.statusCode == 200) {
        showSuccessPopup(); // Show success popup
        return jsonDecode(response.body);
      } else {
        print(
            'Failed to submit withdrawal request - Status Code: ${response.statusCode}');
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String errorMessage = jsonResponse['error'];

        // Show error popup based on the response
        showErrorPopup(errorMessage);

        throw Exception(
            'Failed to submit withdrawal request - ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during withdrawal request: $e');

      // Show error popup for general exception
      showErrorPopup(e.toString());

      throw Exception('Failed to submit withdrawal request - $e');
    }
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(
              'Withdrawal request successful. Amount will be transferred within 48 hours.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorPopup(dynamic errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Withdraw Money',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Existing UI
                CustemText(
                  text:
                      'Balance : ${widget.userData['user_withdraw_amount']} ${widget.userData['user_currency_type'] == 0 ? 'LKR' : 'USD'}',
                  color: const Color(0xffffb100),
                  fontWeight: FontWeight.w800,
                  fontsize: 25,
                ),
                // TextFields for additional information
                const SizedBox(height: 26),
                CustemTextfield(
                  controller: amountController,
                  hintText: 'Amount',
                ),
                const SizedBox(height: 26),
                if (widget.userData['user_currency_type'] == 0) ...{
                  CustemTextfield(
                    controller: accountNameController,
                    hintText: 'Account Name',
                  ),
                  const SizedBox(height: 26),
                  CustemTextfield(
                    controller: accountNumberController,
                    hintText: 'Account Number',
                  ),
                  const SizedBox(height: 26),
                  CustemTextfield(
                    controller: bankController,
                    hintText: 'Bank',
                  ),
                  const SizedBox(height: 26),
                  CustemTextfield(
                    controller: branchController,
                    hintText: 'Branch',
                  ),
                  const SizedBox(height: 26),
                } else ...{
                  CustemTextfield(
                    controller: walletAddressController,
                    hintText: 'Wallet Address',
                  ),
                  const SizedBox(height: 26),
                },
                CustemButton(
                  onTap: () {
                    if (isLoading) {
                      return; // Do nothing if already loading
                    }

                    setState(() {
                      isLoading = true; // Set loading state to true
                    });

                    String apiUrl = widget.userData['user_currency_type'] == 0
                        ? 'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/withdrawmoneylog'
                        : 'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/withdrawmoneylog';

                    // Construct requestBody based on user input
                    dynamic requestBody;

                    if (widget.userData['user_currency_type'] == 0) {
                      // LKR request body
                      requestBody = {
                        "user_id": widget.userData['id'],
                        "requested_amount": int.parse(amountController.text),
                        "account_name": accountNameController.text,
                        "account_number": accountNumberController.text,
                        "bank": bankController.text,
                        "branch": branchController.text,
                      };
                    } else {
                      // USD request body
                      requestBody = {
                        "user_id": widget.userData['id'],
                        "requested_amount": amountController.text,
                        "wallet_address": walletAddressController.text,
                      };
                    }

                    submitWithdrawRequest(apiUrl, requestBody).then((response) {
                      setState(() {
                        isLoading =
                            false; // Set loading state to false after completion
                      });
                    });
                  },
                  text: isLoading ? 'Withdrawing...' : 'Withdraw Money',
                ),
                if (isLoading) ...{
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
