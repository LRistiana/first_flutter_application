import "package:dio/dio.dart";
import "package:first_flutter_application/pages/profile_page.dart";
import "package:first_flutter_application/pages/team_page.dart";
import "package:first_flutter_application/widgets/utils/bottom_nav_bar.dart";
import "package:flutter/material.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  final List<Widget> _pages = [
    // const DasboardPage(),
    const TeamPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        bottomNavigationBar: BottomNavBar(
          onTabchange: (index) => navigateBottomBar(index),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text(
            'Firstore',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
          child: Column(
            children: [
              const DrawerHeader(
                  child: Text('Firstore',
                      style: TextStyle(
                          color: Color.fromRGBO(215, 252, 112, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'))),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.search),
                  title: Text('Search'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.settings),
                  title: Text('settings'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: goLogOut,
                      child: const ListTile(
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                      ))),
            ],
          ),
        ),
        body: _pages[_selectedIndex]);
  }
}
