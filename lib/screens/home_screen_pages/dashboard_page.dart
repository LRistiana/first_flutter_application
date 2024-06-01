import "package:flutter/material.dart";

class DashboardPage
 extends StatefulWidget {
  const DashboardPage
  ({super.key});

  @override
  State<DashboardPage
  > createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DashboardPage
> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            children: [
              // search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    suffixIcon: const Icon(Icons.mic),
                    fillColor: Colors.grey[900],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // message
              Container(
                padding: const EdgeInsets.all(56),
                margin: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(214, 251, 112, 1),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: const Text(
                  'Welcome to Firstore!.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),

              // card
            ],
          ),
        );
  }
}