import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:get_storage/get_storage.dart";
import "package:logger/logger.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final myStorage = GetStorage();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";
  dynamic userData;

  var email = 'xxxxx';
  var name = 'xxxxx';
  var id = 'xxxxx';

  // Future getUser() async {
  //   final dio = Dio();
  //   var logger = Logger();
  //   try {
  //     final response = await dio.get('https://mobileapis.manpits.xyz/api/user',
  //         options: Options(
  //           headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
  //         ));
  //     logger.i(response);
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         email = response.data['data']['email'];
  //         name = response.data['data']['name'];
  //         id = response.data['data']['id'];
  //       });
  //     }
  //   } on DioException catch (e) {
  //     logger.e(e);
  //   }
  // }

  void getUserData() async {
    try {
      var response = await Dio().get("$_apiUrl/user",
          options: Options(headers: {
            'Authorization': "Bearer ${myStorage.read("token")}"
          }));

      if (response.statusCode == 200) {
        setState(() {
          userData = response.data["data"]["user"];
        });
      } else {
        throw DioException.connectionTimeout;
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  @override
  void initState() {
    super.initState();
   getUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            // message
            const Text('Profile',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(214, 251, 112, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat')),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text('Name ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(214, 251, 112, 1),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat')),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text((userData != null ? userData["name"] : "Loading..."),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(214, 251, 112, 1),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat')),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     const Padding(
            //       padding: EdgeInsets.all(1.0),
            //       child: Text('ID ',
            //           textAlign: TextAlign.left,
            //           style: TextStyle(
            //               fontSize: 18,
            //               color: Color.fromRGBO(214, 251, 112, 1),
            //               fontWeight: FontWeight.normal,
            //               fontFamily: 'Montserrat')),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.all(8.0),
            //       child:  Text(myStorage.read('id'),
            //           textAlign: TextAlign.left,
            //           style: const TextStyle(
            //               fontSize: 18,
            //               color: Color.fromRGBO(214, 251, 112, 1),
            //               fontWeight: FontWeight.normal,
            //               fontFamily: 'Montserrat')),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text('Email ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(214, 251, 112, 1),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat')),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((userData != null ? userData["email"] : "Loading..."),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(214, 251, 112, 1),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat')),
                ),
              ],
            ),

            // card
          ],
        ),
      ),
    );
  }
}
