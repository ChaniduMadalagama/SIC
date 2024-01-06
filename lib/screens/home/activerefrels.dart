import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActiveReferralsWidget extends StatefulWidget {
  final String userId;
  final String myReferelId;

  ActiveReferralsWidget({
    required this.userId,
    required this.myReferelId,
  });

  @override
  _ActiveReferralsWidgetState createState() => _ActiveReferralsWidgetState();
}

class _ActiveReferralsWidgetState extends State<ActiveReferralsWidget> {
  late List<dynamic> activeReferrals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchActiveReferrals();
  }

  Future<void> _fetchActiveReferrals() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/activereferrals'),
        body: jsonEncode({'user_id': widget.userId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          activeReferrals = data['data'];
          isLoading = false;
        });
      } else {
        // Handle errors
        print('Error: ${response.reasonPhrase}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      setState(() {
        isLoading = false;
      });
    }
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Active Referrals',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your Referral ID: ${widget.myReferelId}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : activeReferrals.isEmpty
              ? Center(
                  child: Text(
                    'No active referrals',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: activeReferrals.length,
                  itemBuilder: (context, index) {
                    final referral = activeReferrals[index];
                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          referral['bought_package'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Referral by: ${referral['referral_user_name']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        // Add more details as needed
                      ),
                    );
                  },
                ),
    );
  }
}
