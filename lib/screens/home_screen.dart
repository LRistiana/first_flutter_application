import "package:dio/dio.dart";
import "package:first_flutter_application/model/team_members_model.dart";
import "package:first_flutter_application/screens/home_screen_pages/dashboard_page.dart";
import "package:first_flutter_application/screens/home_screen_pages/profile_page.dart";
import "package:first_flutter_application/screens/home_screen_pages/team_page.dart";
import "package:first_flutter_application/widgets/utils/bottom_nav_bar.dart";
import "package:flutter/material.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var logger = Logger();
  final myStorage = GetStorage();
  int _selectedIndex = 0;

  void onLogOut() {
    Navigator.pushNamed(context, '/signIn');
  }

  @override
  void initState() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    teamProvider.fetchTeamMembers();
    super.initState();
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
        // appBar: AppBar(
        //   backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        //   leading: Builder(
        //     builder: (context) => IconButton(
        //       icon: const Icon(Icons.menu),
        //       color: Colors.white,
        //       onPressed: () => Scaffold.of(context).openDrawer(),
        //     ),
        //   ),
        //   title: const Text(
        //     'Firstore',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // drawer: Drawer(
        //   backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        //   child: Column(
        //     children: [
        //       const DrawerHeader(
        //           child: Text('Firstore',
        //               style: TextStyle(
        //                   color: Color.fromRGBO(215, 252, 112, 1),
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.bold,
        //                   fontFamily: 'Montserrat'))),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: ListTile(
        //           iconColor: Colors.white,
        //           textColor: Colors.white,
        //           leading: Icon(Icons.home),
        //           title: Text('Home'),
        //         ),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: ListTile(
        //           iconColor: Colors.white,
        //           textColor: Colors.white,
        //           leading: Icon(Icons.search),
        //           title: Text('Search'),
        //         ),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: ListTile(
        //           iconColor: Colors.white,
        //           textColor: Colors.white,
        //           leading: Icon(Icons.settings),
        //           title: Text('settings'),
        //         ),
        //       ),
        //       Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: GestureDetector(
        //               onTap: goLogOut,
        //               child: const ListTile(
        //                 iconColor: Colors.white,
        //                 textColor: Colors.white,
        //                 leading: Icon(Icons.logout),
        //                 title: Text('Logout'),
        //               ))),
        //     ],
        //   ),
        // ),
        body: Consumer<TeamProvider>(
          builder: (context, teamValue, child) {
            final List<Widget> pages = [
              const DashboardPage(),
               TeamPage(),
              const ProfilePage(),
            ];
            return pages[_selectedIndex];
          },
        ));
  }
}
