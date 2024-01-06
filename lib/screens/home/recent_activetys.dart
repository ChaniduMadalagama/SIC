import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class RecentActivityWidget extends StatefulWidget {
  final String userId;

  RecentActivityWidget({required this.userId});

  @override
  _RecentActivityWidgetState createState() => _RecentActivityWidgetState();
}

class _RecentActivityWidgetState extends State<RecentActivityWidget> {
  late Future<List<String>> activities;

  @override
  void initState() {
    super.initState();
    activities = fetchActivities();
  }

  Future<List<String>> fetchActivities() async {
    final response = await http.post(
      Uri.parse(
          'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/recentactivities'),
      body: jsonEncode({
        "user_id": widget.userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      List<String> messages =
          data.map<String>((item) => item['message_one'].toString()).toList();
      print(response.body);
      return messages;
    } else {
      throw Exception('Failed to load activities');
    }
  }

  Future<void> _refresh() async {
    // Fetch activities again
    setState(() {
      activities = fetchActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future: activities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitWave(
                  color: Color(0xffffb100),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<String> messages = snapshot.data as List<String>;
              return Container(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.grey[900],
                      child: ListTile(
                        title: Text(
                          messages[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
