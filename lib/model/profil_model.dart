import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';


class ProfilProvider with ChangeNotifier{
  
}

class ProfileModel{
  late int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String photo;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.photo,
  });

  ProfileModel.fullData(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.photo,
  );

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel.fullData(
      json['id'],
      json['name'],
      json['email'],
      json['phone'],
      json['address'],
      json['photo'],
    );
  }
}