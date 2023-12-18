import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final email = TextEditingController();
    final phoneNumber = TextEditingController();
    final address = TextEditingController();
    final city = TextEditingController();
    final country = TextEditingController();
    final zipCode = TextEditingController();

    final password = TextEditingController();
    final conformpassword = TextEditingController();

    FocusNode focusNode = FocusNode();
    const isobscureText = false;

    String countryValue = "";

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
                controller: firstName,
                hintText: 'First Name',
              ),
              const SizedBox(
                height: 26,
              ),
              CustemTextfield(
                controller: lastName,
                hintText: 'Last Name',
              ),
              const SizedBox(
                height: 26,
              ),
              CustemTextfield(
                controller: email,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 26,
              ),
              // CustemTextfield(
              //   controller: phone_number,
              //   hintText: 'Phone Number',
              // ),
              IntlPhoneField(
                controller: phoneNumber,
                focusNode: focusNode,
                obscureText: isobscureText,
                decoration: InputDecoration(
                  counterText: null,
                  counterStyle: const TextStyle(color: Colors.white),
                  //counter: SizedBox.shrink(),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                  // border: OutlineInputBorder(
                  //   borderSide: BorderSide(),
                  // ),
                ),
                languageCode: "en",
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  print('Country changed to: ' + country.name);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustemTextfield(
                controller: address,
                hintText: 'Address',
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: city,
                hintText: 'City',
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: country,
                hintText: 'Country',
                
              ),
              CSCPicker(
                showStates: false,
                showCities: false,
                flagState: CountryFlag.ENABLE, // Display country flags
                dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                countrySearchPlaceholder: "Countrys",
                countryDropdownLabel: "Select Country",
                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownHeadingStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: zipCode,
                hintText: 'Zip Code',
              ),
              const SizedBox(
                height: 29,
              ),
              CustemTextfield(
                controller: password,
                hintText: 'Password',
                isobscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustemTextfield(
                controller: conformpassword,
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
