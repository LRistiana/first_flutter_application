import 'package:first_flutter_application/model/interest_model.dart';
import 'package:first_flutter_application/model/user_model.dart';
import 'package:first_flutter_application/screens/home_screen.dart';
import 'package:first_flutter_application/screens/intro_screen.dart';
import 'package:first_flutter_application/screens/sign_in_screen.dart';
import 'package:first_flutter_application/screens/sign_up_screen.dart';
import 'package:first_flutter_application/screens/tabungan_page.dart';
import 'package:first_flutter_application/screens/member_screen.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => InterestProvider()),
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
        '/' : (context) => const  IntroScreen(),
        '/signIn' : (context) => const  SignIn(),
        '/signUp' : (context) =>  const SignUp(),
        '/homePage' : (context) =>  const HomeScreen(),
        '/member' : (context) =>   MemberScreenWrapper(),
        '/tabungan' : (context) =>  TabunganPageWrapper(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: false,
      theme: ThemeData(
        primaryColor: GeneralColor.primaryColor,
      ),
    );
  }
}

class MemberScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int? memberID = ModalRoute.of(context)?.settings.arguments as int?;
      if (memberID == null) {
        // Jika argument null, navigasi kembali ke homepage
        Navigator.of(context).pushReplacementNamed('/homePage');
      } else {
        return MemberScreen(memberID: memberID);
      }
      
    // Jika memberID null, maka akan kembali ke homepage
    return const SizedBox.shrink();
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