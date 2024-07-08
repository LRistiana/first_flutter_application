// import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:logger/logger.dart';



class UserModel {
  late int id;
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });

  UserModel.fullData(
    this.id,
    this.name,
    this.email,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.fullData(
      json['id'],
      json['name'],
      json['email'],
    );
  }
}

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final myStorage = GetStorage();
  final String _apiUrl = "https://mobileapis.manpits.xyz/api";

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> logOut() async {
    try {
      final response = await Dio().get('$_apiUrl/logout',
          options: Options(
            headers: {'Authorization': 'Bearer ${myStorage.read("token")}'},
          ));
      Logger().i(response.data['message']);
    } on DioException catch (e) {
      Logger().e(e.response?.data['message']);
    }
    notifyListeners();
  }

  Future<int> logIn(String email, String password) async {
    final response = await Dio().post('$_apiUrl/login', data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return 200;
    } else {
      return response.statusCode!;
    }
  }

  Future<void> fetchUser() async {
    try {
      var response = await Dio().get("$_apiUrl/user",
          options: Options(
              headers: {'Authorization': "Bearer ${myStorage.read("token")}"}));

      if (response.statusCode == 200) {
        dynamic userData = response.data["data"]["user"];
        _user = UserModel.fromJson(userData);
        notifyListeners();
        Logger().i('${response.statusCode}\n${response.data['message']}');

      } else {
        throw DioException.connectionTimeout;
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  Future<void> register() async {}
}
