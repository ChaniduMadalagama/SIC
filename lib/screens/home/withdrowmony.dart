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
  // ignore: library_private_types_in_public_api
  _SicWithdrowMoneyState createState() => _SicWithdrowMoneyState();
}

class _SicWithdrowMoneyState extends State<SicWithdrowMoney> {
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController walletAddressController = TextEditingController();

  Future<Map<String, dynamic>> submitWithdrawRequest(
      String apiUrl, dynamic requestBody) async {
    try {
      final response =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(requestBody));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            'Failed to submit withdrawal request - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to submit withdrawal request');
      }
    } catch (e) {
      print('Exception during withdrawal request: $e');
      throw Exception('Failed to submit withdrawal request');
    }
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
                      '\Balance : ${widget.userData['user_account_balance']} ${widget.userData['user_currency_type'] == 0 ? 'LKR' : 'USD'}',
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
                if (widget.userData['user_currency_type'] == 0) ...[
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
                ] else ...[
                  CustemTextfield(
                    controller: walletAddressController,
                    hintText: 'Wallet Address',
                  ),
                ],
                const SizedBox(height: 26),
                CustemButton(
                  onTap: () {
                    print(widget.userData['id']);
                    print(widget.userData['user_currency_type']);

                    String apiUrl = widget.userData['user_currency_type'] == 0
                        ? 'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/withdrawmoneylog_lkr'
                        : 'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/withdrawmoneylog_usd';

                    // Construct requestBody based on user input
                    dynamic requestBody = {
                      "user_id": '65900ad7c6fdb85bb86de9cf',
                      "requested_amount": amountController.text,
                      "account_name": accountNameController.text,
                      "account_number": accountNumberController.text,
                      "bank": bankController.text,
                      "branch": branchController.text
                      // Add other fields based on user input
                    };

                    submitWithdrawRequest(apiUrl, requestBody)
                        .then((response) {});
                  },
                  text: 'Withdraw Money',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
