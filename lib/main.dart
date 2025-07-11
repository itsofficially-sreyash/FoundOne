import 'package:flutter/material.dart';
import 'package:found_one/presentation/screens/auth/otp_screen.dart';
import 'package:found_one/presentation/screens/auth/phone_name_entry_screen.dart';
import 'package:found_one/presentation/screens/home/bottom_navbar.dart';
import 'package:found_one/presentation/screens/home/home_screen.dart';
import 'package:found_one/presentation/screens/post/create_post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoundOne',
        routes: {
          '/verification': (context) => PhoneNameEntryScreen(),
          '/otpVerification': (context) => OtpScreen(),
          '/navbar': (context) => BottomNavbar(),
          '/home': (context) => HomeScreen(),
          '/post': (context) => CreatePostScreen()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const PhoneNameEntryScreen(),
      ),
    );
  }
}
