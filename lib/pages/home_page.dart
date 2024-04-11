// import "package:first_flutter_application/utils/bottom_nav_bar.dart";
import "package:first_flutter_application/utils/bottom_nav_bar.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        bottomNavigationBar: const BottomNavBar(),
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
        drawer: const Drawer(
          backgroundColor: Color.fromRGBO(17, 17, 17, 1),
          child: Column(
            children: [
              DrawerHeader(
                  child: Text('Firstore',
                      style: TextStyle(
                          color: Color.fromRGBO(215, 252, 112, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'))),
              
              
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.home),
                  title:  Text('Home'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.search),
                  title:  Text('Search'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.settings),
                  title:  Text('settings'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(Icons.logout),
                  title:  Text('Logout'),
                ),
              ),
            ],
          ),
        ),
        body: const Center(
          child: Text(
            'Home Page',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ));
  }
}
