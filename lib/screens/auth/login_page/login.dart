import 'package:flutter/material.dart';
import 'package:sic/components/custem_button.dart';
import 'package:sic/components/custem_text.dart';
import 'package:sic/components/custem_textfeeld.dart';
import 'package:sic/home/home.dart';
import 'package:sic/screens/auth/register_page/register.dart';
import 'package:sic/utils/utill_functions.dart';

class SicLoginPage extends StatefulWidget {
  const SicLoginPage({super.key});

  @override
  State<SicLoginPage> createState() => _SicLoginPageState();
}

class _SicLoginPageState extends State<SicLoginPage> {
  @override
  Widget build(BuildContext context) {
    final _email = TextEditingController();
    final _password = TextEditingController();
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
                      'Login here',
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
                      'Welcome back you’ve\nbeen missed!',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 20,
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
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    //  UtillFunction.navigateTo(context, const FogotPassword());
                  },
                  child: const CustemText(
                    text: 'Forgot your password',
                    fontsize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  onTap: () {
                    UtillFunction.navigateTo(context, const Home());
                  },
                  text: 'Login'),
              const SizedBox(
                height: 30,
              ),
              CustemButton(
                  textcolor: Colors.black,
                  height: 40,
                  fontsize: 14,
                  color: Colors.white,
                  onTap: () {
                    UtillFunction.navigateTo(context, const SicRegister());
                  },
                  text: 'Create new account'),
            ],
          ),
        ),
      ),
    );
  }
}
