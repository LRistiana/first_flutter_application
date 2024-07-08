import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class InterestModel {
  late int id;
  final double percent;
  final int isActive;

  InterestModel({
    required this.percent,
    required this.isActive,
  });

  InterestModel.fullData(
    this.id,
    this.percent,
    this.isActive,
  );

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel.fullData(
      json['id'],
      json['persen'],
      json['isaktif'],
    );
  }
}

class InterestProvider with ChangeNotifier {
  List<InterestModel> _interests = [];
  InterestModel? _activeInterest;
  final myStorage = GetStorage();
  final String _apiUrl = "https://mobileapis.manpits.xyz/api";

  List<InterestModel> get interests => _interests;
  InterestModel? get activeInterest => _activeInterest;


  Future<void> getInterests() async {
    try {
      final response = await Dio().get('$_apiUrl/settingbunga',
          options: Options(
            headers: {'Authorization': 'Bearer ${myStorage.read("token")}'},
          ));
      if (response.statusCode == 200) {
        dynamic interestsData = response.data['data']['settingbungas'];
        _interests = interestsData
            .map<InterestModel>((interest) => InterestModel.fromJson(interest))
            .toList();
        dynamic activeInterest = response.data['data']["activebunga"];
        if (activeInterest == null) {
          _activeInterest = null;
        }else{
          _activeInterest = InterestModel.fromJson(activeInterest);
        }
        // _activeInterest = InterestModel.fromJson(activeInterest);
        notifyListeners();
        Logger().i('${response.statusCode}\n${response.data['message']}');
      } else {
        Logger().e(response.data['message']);
      }
    } on DioException catch (e) {
      Logger().e(e.response?.data['message']);
    }
  }

  Future<String> addInterest(InterestModel interest) async {
    try {
      final response = await Dio().post('$_apiUrl/addsettingbunga',
          data: {
            'persen': interest.percent,
            'isaktif': interest.isActive,
          },
          options: Options(
            headers: {'Authorization': 'Bearer ${myStorage.read("token")}'},
          ));
      if (response.statusCode == 200) {
        getInterests();
        // notifyListeners();
        Logger().i('${response.statusCode}\n${response.data['message']}');
        return "success/${response.data['message']}";
      } else {
        Logger().e(response.data['message']);
        return response.data['message'];
      }
    } on DioException catch (e) {
      Logger().e(e.response?.data['message']);
      return e.response?.data['message'];
    }
  }
}
