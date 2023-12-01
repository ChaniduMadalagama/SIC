import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sic/screens/card/card.dart';
import 'package:sic/screens/home/home.dart';
import 'package:sic/screens/profile/profile.dart';
import 'package:sic/screens/transactions/transaction.dart';

class SicCommonScreen extends StatefulWidget {
  const SicCommonScreen({Key? key}) : super(key: key);

  @override
  State<SicCommonScreen> createState() => _SicCommonScreenState();
}

class _SicCommonScreenState extends State<SicCommonScreen> {
  int _selectedTab = 0;

  // Define your pages here
  final List<Widget> _pages = [
    Home(),
    SicProfile(),
    SicTransAtions(),
    SicCard(),
  ];

  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _pages,
      items: [
        PersistentBottomNavBarItem(
            icon: Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.credit_card),
            title: 'Card',
            activeColorPrimary: Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.monetization_on),
            title: 'Transaction',
            activeColorPrimary: Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.person),
            title: 'Profile',
            activeColorPrimary: Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
      ],
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.black,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
    );
  }
}
