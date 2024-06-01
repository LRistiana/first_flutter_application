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
        '/member' : (context) =>  const MemberScreen(),
        '/tabungan' : (context) =>  TabunganPageWrapper(),
      },
      initialRoute: '/',
      checkerboardOffscreenLayers: false,
      theme: ThemeData(
        primaryColor: GeneralColor.primaryColor,
      ),
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