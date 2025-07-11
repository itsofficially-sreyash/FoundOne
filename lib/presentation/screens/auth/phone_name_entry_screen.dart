import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:found_one/presentation/screens/auth/otp_screen.dart';
import 'package:found_one/presentation/widgets/custom_button.dart';
import 'package:found_one/presentation/widgets/custom_text_field.dart';

class PhoneNameEntryScreen extends StatefulWidget {
  const PhoneNameEntryScreen({super.key});

  @override
  State<PhoneNameEntryScreen> createState() => _PhoneNameEntryScreenState();
}

class _PhoneNameEntryScreenState extends State<PhoneNameEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid phone number (10 digits)";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 380,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "We value your privacy. \nYour data is safe with us",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomTextField(
                      controller: nameController,
                      hintText: "Name",
                      labelText: "Name",
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.person_2),
                      validator: _validateName,
                      focusNode: _nameFocus,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomTextField(
                      controller: phoneController,
                      hintText: "Phone Number",
                      labelText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone),
                      validator: _validatePhone,
                      focusNode: _phoneFocus,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 50,
                      child: CustomElevatedButton(
                        text: "Less go  🚀",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Text(
                    "*We collect this information so that seeker can contact you",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
