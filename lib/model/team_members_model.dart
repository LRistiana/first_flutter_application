import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class TeamMember {
  final int id;
  final int nomorInduk;
  final String nama;
  final String alamat;
  final String tanggalLahir;
  final String telepon;
  final String imageUrl;
  final int statusAktif;

  TeamMember({
    required this.id,
    required this.nomorInduk,
    required this.nama,
    required this.alamat,
    required this.tanggalLahir,
    required this.telepon,
    required this.imageUrl,
    required this.statusAktif,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json['id'],
      nomorInduk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tanggalLahir: json['tgl_lahir'],
      telepon: json['telepon'],
      imageUrl: json['image_url'] ?? '',
      statusAktif: json['status_aktif'],
    );
  }
}

class TeamProvider with ChangeNotifier {
  List<TeamMember> _teamMembers = [];
  TeamMember _member = TeamMember(
    id: 0,
    nomorInduk: 0,
    nama: '',
    alamat: '',
    tanggalLahir: '',
    telepon: '',
    imageUrl: '',
    statusAktif: 0,
  );

  final myStorage = GetStorage();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api/anggota";
  static const String _apiUrlSaldo = "https://mobileapis.manpits.xyz/api/saldo";

  List<TeamMember> get teamMembers => _teamMembers;
  TeamMember get member => _member; 

  Future<void> fetchTeamMembers() async {
    try {
      Response response = await Dio().get(_apiUrl,
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final List<dynamic> anggotas = response.data['data']['anggotas'];
        _teamMembers =
            anggotas.map((member) => TeamMember.fromJson(member)).toList();
        notifyListeners();
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  Future<void> fetchMember(int memberID) async {
    try {
      Response response = await Dio().get("$_apiUrl/$memberID",
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final dynamic anggotas = response.data['data']['anggota'];
        _member = TeamMember.fromJson(anggotas);
        notifyListeners();
        // ignore: avoid_print
        print("sucess fetch member");
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  Future<int> getSaldo(int anggotaID) async {
    try {
      Response response = await Dio().get('$_apiUrlSaldo/$anggotaID',
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final int saldo = response.data['data']['saldo'];
        return saldo;
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
      return 0;
    }
  }

  Future<void> deleteMember(int memberId) async {
    try {
      Response response = await Dio().delete('$_apiUrl/$memberId',
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      // headers: {"Authorization": "Bearer hai"}));

      if (response.statusCode == 200) {
        _teamMembers.removeWhere((member) => member.id == memberId);
        notifyListeners();
      } else {
        throw Exception('Gagal menghapus anggota tim $memberId');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  Future<void> addMember(TeamMember member) async {
    try {
      final response =
          await Dio().post("https://mobileapis.manpits.xyz/api/anggota",
              data: {
                "nomor_induk": member.nomorInduk,
                "nama": member.nama,
                "alamat": member.alamat,
                "telepon": member.telepon,
                "tgl_lahir": member.tanggalLahir,
                // "nomor_induk": "999999",
                // "nama": "sajajaj",
                // "alamat": "ajasjn",
                // "telepon": "99992222",
                // "tgl_lahir": "2021-02-12",
              },
              options: Options(
                headers: {
                  "Authorization": "Bearer ${myStorage.read("token")}",
                },
              ));
      if (response.statusCode == 200) {
        fetchTeamMembers();
      } else {
        throw Exception('Gagal menambahkan anggota tim');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }

  Future<void> updateMember(TeamMember member) async {
    try {
      final response = await Dio().put("$_apiUrl/${member.id}",
          data: {
            "nomor_induk": member.nomorInduk,
            "nama": member.nama,
            "alamat": member.alamat,
            "telepon": member.telepon,
            "tgl_lahir": member.tanggalLahir,
            "status_aktif": 1,
          },
          options: Options(
            headers: {
              "Authorization": "Bearer ${myStorage.read("token")}",
            },
          ));
      if (response.statusCode == 200) {
        fetchTeamMembers();
      } else {
        throw Exception('Gagal mengupdate anggota tim');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    }
  }
}
