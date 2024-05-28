// import 'dart:js';

import 'package:first_flutter_application/pages/home_page.dart';
import 'package:first_flutter_application/pages/intro_page.dart';
import 'package:first_flutter_application/pages/sign_in_page.dart';
import 'package:first_flutter_application/pages/sign_up_page.dart';
import 'package:first_flutter_application/pages/tabungan_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/team_members_model.dart'; 
import 'model/tabungan_model.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamProvider()),
        ChangeNotifierProvider(create: (_) => TabunganProvider()),
        ChangeNotifierProvider(create: (_) => JenisTransaksiProvider()),
      ],
      child: const MyApp(),
    ),  
  );
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
        '/tabungan' : (context) =>  TabunganPageWrapper(),
      },
      initialRoute: '/',
      checkerboardOffscreenLayers: false,
    );
  }
}

class TabunganPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int? memberID = ModalRoute.of(context)?.settings.arguments as int?;
    
      if (memberID == null) {
        // Jika argument null, navigasi kembali ke homepage
        Navigator.of(context).pushReplacementNamed('/homePage');
      } else {
        return TabunganPage(memberID: memberID);
      }
      
    // Jika memberID null, maka akan kembali ke homepage
    return const SizedBox.shrink();
  }
}

