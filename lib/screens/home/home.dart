import 'package:flutter/material.dart';
import 'package:sic/components/custem_text.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> userData;
  const Home({super.key, required this.userData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      'https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustemText(
                      text: widget.userData['first_name'] +
                          ' ' +
                          widget.userData['last_name'],
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontsize: 16,
                    ),
                    const CustemText(
                      text: 'Good Morning!',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontsize: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 27,
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
            const CustemText(
              text: '\$42,295.00 USD',
              color: Color(0xffB6EF11),
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
                      Container(
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
                      const SizedBox(
                        height: 10,
                      ),
                      const CustemText(
                        text: 'Fund Transfer',
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
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustemText(
                        text: 'Add Money',
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
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontsize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
