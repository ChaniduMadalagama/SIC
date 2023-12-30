import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sic/screens/card/card.dart';
import 'package:sic/screens/home/home.dart';
import 'package:sic/screens/profile/profile.dart';
import 'package:sic/screens/transactions/transaction.dart';

class SicCommonScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SicCommonScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<SicCommonScreen> createState() => _SicCommonScreenState();
}

class _SicCommonScreenState extends State<SicCommonScreen> {
  late PersistentTabController _controller;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    super.initState();
    _controller = PersistentTabController();
    _pages = [
      Home(userData: widget.userData),
      const SicTransAtions(),
       SicCard(userData: widget.userData),
       SicProfile(userData: widget.userData),
    ];
  }

  // @override
  // void initState() {
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _pages,
      items: [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: const Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.credit_card),
            title: 'Card',
            activeColorPrimary: const Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.monetization_on),
            title: 'Packagers',
            activeColorPrimary: const Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: 'Profile',
            activeColorPrimary: const Color(0xffD3F570),
            inactiveColorPrimary: Colors.white),
      ],
      decoration: const NavBarDecoration(
        colorBehindNavBar: Color(0xff181816),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.black,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
    );
  }
}
