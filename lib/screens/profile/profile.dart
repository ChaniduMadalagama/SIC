import 'package:flutter/material.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/screens/profile/profile_verification.dart';
import 'package:sic/utils/utill_functions.dart';

class SicProfile extends StatefulWidget {
   final Map<String, dynamic> userData;
  const SicProfile({super.key, required this.userData});

  @override
  State<SicProfile> createState() => _SicProfileState();
}

class _SicProfileState extends State<SicProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 77,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              height: 204,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1B1B1B),
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    width: 80,
                    height: 80,
                    child: Image.network(
                        "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustemText(
                    text: 'Chanidu Madalagama',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontsize: 16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustemText(
                    text: 'tonikross@gmai.com',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontsize: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                UtillFunction.navigateTo(context, FileUploadPage(userData: widget.userData,));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xff1B1B1B),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xffD3F570),
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustemText(
                      text: 'Profile verification',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontsize: 16,
                    ),
                    const Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1B1B1B),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xff9280FD),
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustemText(
                    text: 'Profile setting',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontsize: 16,
                  ),
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1B1B1B),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xffD3F570),
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustemText(
                    text: 'Setting',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontsize: 16,
                  ),
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1B1B1B),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xff9280FD),
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(
                      Icons.support_agent,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustemText(
                    text: 'Support',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontsize: 16,
                  ),
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1B1B1B),
                  borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                onTap: () {
                  UtillFunction.logout(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xffD3F570),
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustemText(
                      text: 'Sign out',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontsize: 16,
                    ),
                    const Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
