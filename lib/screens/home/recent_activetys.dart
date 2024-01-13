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
  late Future<List<Map<String, dynamic>>> activities;

  @override
  void initState() {
    super.initState();
    activities = fetchActivities();
  }

  Future<List<Map<String, dynamic>>> fetchActivities() async {
    final response = await http.post(
      Uri.parse(
          'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/recentactivities'),
      body: jsonEncode({"user_id": widget.userId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      List<Map<String, dynamic>> messages = data.cast<Map<String, dynamic>>();
      return messages;
    } else {
      throw Exception('Failed to load activities');
    }
  }

  int getTagId(dynamic tag) {
    if (tag is int) {
      return tag;
    } else {
      // Handle the case where tag is null or not an int
      return 0; // You can provide a default value or handle it according to your requirements
    }
  }

  Color getMessageColor(int tagId) {
    if (tagId == 1) {
      return Colors.green;
    } else if (tagId == 2) {
      return Colors.red;
    } else if (tagId == 3) {
      return Colors.orange;
    } else {
      return Colors.grey; // Default color for cases where there is no tag
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
              List<Map<String, dynamic>> messages =
                  snapshot.data as List<Map<String, dynamic>>;
              return Container(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // Extract tag ID from the API response
                    int tagId = getTagId(messages[index]['tag']);

                    // Determine the color based on tag ID or default to gray
                    Color messageColor = getMessageColor(tagId);

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: messageColor,
                      child: ListTile(
                        title: Text(
                          messages[index]['message_one'].toString(),
                          //style: TextStyle(color: messageColor),
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
