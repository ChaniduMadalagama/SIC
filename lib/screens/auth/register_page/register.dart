import 'package:flutter/material.dart';
import 'package:sic/components/custem_button.dart';
import 'package:sic/components/custem_textfeeld.dart';
import 'package:sic/utils/utill_functions.dart';

class SicRegister extends StatefulWidget {
  const SicRegister({super.key});

  @override
  State<SicRegister> createState() => _SicRegisterState();
}

class _SicRegisterState extends State<SicRegister> {
  @override
  Widget build(BuildContext context) {
    final _email = TextEditingController();
    final _password = TextEditingController();
    final _conformpassword = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 73,
              ),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xffD3F570),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Create an account so you can explore all the\nexisting jobs',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              CustemTextfield(
                controller: _email,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: _password,
                hintText: 'Password',
                isobscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustemTextfield(
                controller: _conformpassword,
                hintText: 'Confirm Password',
                isobscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  onTap: () {
                    //UtillFunction.navigateTo(context, const HomeScreen());
                  },
                  text: 'Sign up'),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  textcolor: Colors.black,
                  height: 40,
                  fontsize: 14,
                  color: Colors.white,
                  onTap: () {
                    UtillFunction.goBack(context);
                  },
                  text: 'Already have an account'),
            ],
          ),
        ),
      ),
    );
  }
}
