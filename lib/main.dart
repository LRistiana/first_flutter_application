// import 'dart:js';

import 'package:first_flutter_application/pages/home_page.dart';
import 'package:first_flutter_application/pages/intro_page.dart';
import 'package:first_flutter_application/pages/sign_in_page.dart';
import 'package:first_flutter_application/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => const  IntroPage(),
        '/signIn' : (context) => const  SignIn(),
        '/signUp' : (context) =>  const SignUp(),
        '/homePage' : (context) =>  const HomePage(),
      },
      initialRoute: '/',
      checkerboardOffscreenLayers: false,
    );
  }
}