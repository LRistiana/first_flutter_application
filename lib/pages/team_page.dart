// import "package:dio/dio.dart";
// import "package:first_flutter_application/utils/bottom_nav_bar.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
// import "package:get_storage/get_storage.dart";
// import "package:logger/logger.dart";


class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
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
                  'See Our Team!.',
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