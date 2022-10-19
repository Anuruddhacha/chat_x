import 'package:chatme/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: OnBoardingScreen(),
    );
  }
}
