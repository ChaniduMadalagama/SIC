import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sic/screens/card/buy_packagers.dart';
import 'package:sic/utils/utill_functions.dart';

class SicCard extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SicCard({Key? key, required this.userData}) : super(key: key);

  @override
  State<SicCard> createState() => _SicCardState();
}

class _SicCardState extends State<SicCard> {
  List<dynamic> packages = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/getpackages'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        packages = jsonData['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Package Data',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: packages.isEmpty
            ? Center(
                child: SpinKitWave(
                  color: Color.fromARGB(255, 236, 216, 168),
                ),
              )
            : ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return Card(
                    margin: const EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () {
                        UtillFunction.navigateTo(
                            context,
                            BuyPackagePage(
                              packageID: package['id'],
                              userData: widget.userData,
                            ));
                        print(package);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 209, 209),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                package['name'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Code: ${package['code']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Description: ${package['description']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Rate: ${package['rate']}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
