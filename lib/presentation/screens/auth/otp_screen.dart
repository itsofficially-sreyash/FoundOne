import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:found_one/presentation/screens/home/home_screen.dart';
import 'package:found_one/presentation/widgets/custom_button.dart';
import 'package:found_one/presentation/widgets/custom_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final _otpFocus = FocusNode();

  void dispose() {
    otpController.dispose();
    _otpFocus.dispose();
  }

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(elevation: 0, forceMaterialTransparency: true),
      body: Form(
        key: _formKey,
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Enter OTP",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextField(
                          controller: otpController,
                          hintText: "Enter OTP",
                          keyboardType: TextInputType.phone,
                          labelText: "Enter OTP",
                          prefixIcon: Icon(Icons.password),
                          focusNode: _otpFocus,
                          validator: _validateOtp,
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // OTP is valid, proceed with login
                            }
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blueAccent,
                              // decoration: TextDecoration.underline
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 50,
                      child: CustomElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            Navigator.popAndPushNamed(
                              context,
                              '/navbar'
                            );
                          }
                        },
                        text: "Submit",
                      ),
                    ),
                  ),
                  SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
