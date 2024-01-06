import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/screens/home/activerefrels.dart';
import 'package:sic/screens/home/recent_activetys.dart';
import 'package:sic/screens/home/withdrowmony.dart';
import 'package:sic/utils/utill_functions.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Map<String, dynamic> userData;
  Home({Key? key, required this.userData}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int refreshCounter = 0;
  late AnimationController _controller;
  String greetingMessage = 'Loading...';
  late Timer _timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    updateGreetingMessage();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      updateGreetingMessage();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> refreshUserData() async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl =
        'https://sicweb-78c6801c0953.herokuapp.com/api/v1/mobileapi/app/refreshuser';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_key': '7760524e-7334-4ae6-bd3d-cd0a5ba8a09c',
          'user_id': widget.userData['id'],
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> refreshedUserData =
            jsonDecode(response.body);

        print('Refreshed Data: $refreshedUserData');

        if (refreshedUserData['userData'] != null) {
          setState(() {
            widget.userData = refreshedUserData['userData'];
          });
          updateGreetingMessage();
        } else {
          print('userData is null in refreshedUserData');
        }
      } else {
        print('Failed to refresh user data: ${response.statusCode}');
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        print('Error message: ${errorData['message']}');
      }
    } catch (error) {
      print('Error during API request: $error');
    }

    setState(() {
      refreshCounter++;
    });
  }

  Future<void> refreshRecentActivity() async {
    setState(() {
      // Your logic to refresh RecentActivityWidget
    });
  }

  void updateGreetingMessage() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    setState(() {
      if (hour < 12) {
        greetingMessage = 'Good Morning!';
      } else if (hour < 17) {
        greetingMessage = 'Good Afternoon!';
      } else {
        greetingMessage = 'Good Evening!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateGreetingMessage();
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshUserData();
          await refreshRecentActivity();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustemText(
                            text:
                                '${widget.userData['first_name'] ?? ''} ${widget.userData['last_name'] ?? ''}',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontsize: 16,
                          ),
                          CustemText(
                            text: greetingMessage,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontsize: 12,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      IconButton(
                        onPressed: () async {
                          await refreshUserData();
                        },
                        icon: isLoading
                            ? SpinKitWave(
                                color: Color(0xffffb100),
                                size: 25,
                              )
                            : const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 27,
              ),
              Text(
                widget.userData['active_status'] == 1
                    ? 'Account is Active'
                    : 'Account Activation Pending',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: widget.userData['active_status'] == 1
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustemText(
                text: 'Total balance',
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontsize: 12,
              ),
              const SizedBox(
                height: 10,
              ),
              CustemText(
                text:
                    '\ ${widget.userData['user_account_balance']} ${widget.userData['user_currency_type'] == 0 ? 'LKR' : 'USD'}',
                color: const Color(0xffffb100),
                fontWeight: FontWeight.w800,
                fontsize: 28,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            UtillFunction.navigateTo(context,
                                SicWithdrowMoney(userData: widget.userData));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xff1B1B1B),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustemText(
                          text: 'Withdraw Money',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontsize: 14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff1B1B1B),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            onTap: () {
                              UtillFunction.navigateTo(
                                context,
                                ActiveReferralsWidget(
                                  userId: '65900e97c6fdb85bb86de9df',
                                  myReferelId:
                                      widget.userData['user_referral_code'],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustemText(
                          text: 'Active referrals',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontsize: 14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff1B1B1B),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustemText(
                          text: 'More',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontsize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const CustemText(
                text: 'Recent activity',
                color: Color(0xffffb100),
                fontWeight: FontWeight.w600,
                fontsize: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await refreshRecentActivity();
                  },
                  child: RecentActivityWidget(
                    userId: widget.userData['id'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18),
        child: FloatingActionButton(
          onPressed: () {
            // Replace 'your_whatsapp_group_link' with the actual invite link
            launch('https://chat.whatsapp.com/KAcBWyCMUX87PrH491eBgB');
          },
          child: Image.asset(
            'assets/images/whatsapp.png', 
          ),
        ),
      ),
    );
  }
}
