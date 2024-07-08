import "package:dio/dio.dart";
// import "package:first_flutter_application/model/team_members_model.dart";
import "package:first_flutter_application/screens/home_screen_pages/dashboard_page.dart";
import "package:first_flutter_application/screens/home_screen_pages/interest_page.dart";
import "package:first_flutter_application/screens/home_screen_pages/profile_page.dart";
import "package:first_flutter_application/screens/home_screen_pages/team_page.dart";
import "package:first_flutter_application/widgets/utils/bottom_nav_bar.dart";
import "package:flutter/material.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";
// import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<Widget> pages = [
  const DashboardPage(),
  const TeamPage(),
  // const ProfilePage(),
  const InterestScreen()
];

class _HomeScreenState extends State<HomeScreen> {
  var logger = Logger();
  final myStorage = GetStorage();
  int _selectedIndex = 0;

  void onLogOut() {
    Navigator.pushNamed(context, '/signIn');
  }

  void goLogOut() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://mobileapis.manpits.xyz/api/logout',
              options: Options(
                headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
              ));
      logger.i(response);
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/signIn');
        myStorage.remove('token');
      } else if (response.statusCode == 406) {
        Navigator.pushNamed(context, '/signIn');
        myStorage.remove('token');
      }
    } on DioException catch (e) {
      logger.e(e);
      Navigator.pushNamed(context, '/signIn');
      myStorage.remove('token');
    }
  }

  // onTabChange
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        bottomNavigationBar: BottomNavBar(
          onTabchange: (index) => navigateBottomBar(index),
        ),
        body: pages[_selectedIndex]);
  }
}
