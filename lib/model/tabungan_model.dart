import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_application/model/team_members_model.dart';

class Tabungan {
  late int id;
  final int transaksiID;
  final int nominal;
  late String tanggal;

  Tabungan({
    required this.transaksiID,
    required this.nominal,
  });

  Tabungan.fullData(
    this.id,
    this.transaksiID,
    this.nominal,
    this.tanggal,
  );

  factory Tabungan.fromJson(Map<String, dynamic> json) {
    return Tabungan.fullData(
      json['id'],
      json['trx_id'],
      json['trx_nominal'],
      json['trx_tanggal'],
    );
  }
}

class TabunganProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Tabungan> _tabungans = [];
  final myStorage = GetStorage();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api/tabungan";
  List<Tabungan> get tabungans => _tabungans;

  bool get isLoading => _isLoading;
  Future<void> fetchTabungans(int member) async {
    _isLoading = true;
    try {
      Response response = await Dio().get('$_apiUrl/${member.toString()}',
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final List<dynamic> tabungans = response.data['data']['tabungan'];
        _tabungans =
            tabungans.map((tabungan) => Tabungan.fromJson(tabungan)).toList();
            _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        print(response);
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (e) {
      print(e);
      throw Exception('Gagal mengambil data dari API');
    }
  }

  Future<void> addTabungan(TeamMember member, Tabungan tabungan) async {
    try {
      Response response = await Dio().post(_apiUrl,
          data: {
            "anggota_id": member.id,
            'trx_id': tabungan.transaksiID,
            'trx_nominal': tabungan.nominal,
          },
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

class JenisTransaksiProvider with ChangeNotifier {
  final myStorage = GetStorage();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api/jenistransaksi";
  List<JenisTransaksi> _jenisTransaksiList = [];
  bool _isLoading = false;

  List<JenisTransaksi> get jenisTransaksiList => _jenisTransaksiList;
  bool get isLoading => _isLoading;

  Future<void> fetchTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await Dio().get(_apiUrl,
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final List<dynamic> jenistransaksi = response.data['data']['jenistransaksi'];
        _jenisTransaksiList =
            jenistransaksi.map((member) => JenisTransaksi.fromJson(member)).toList();
        notifyListeners();
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class JenisTransaksi {
  final int id;
  final String trxName;
  final int trxMultiply;

  JenisTransaksi({
    required this.id,
    required this.trxName,
    required this.trxMultiply,
  });

  factory JenisTransaksi.fromJson(Map<String, dynamic> json) {
    return JenisTransaksi(
      id: json['id'],
      trxName: json['trx_name'],
      trxMultiply: json['trx_multiply'],
    );
  }
}
