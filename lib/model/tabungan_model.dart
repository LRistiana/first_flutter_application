import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';


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
  // ignore: unused_field
  bool _isChaced = false;

  List<Tabungan> _tabungans = [];

  final myStorage = GetStorage();

  static const String _apiUrl = "https://mobileapis.manpits.xyz/api/tabungan"; 
  static const String _apiUrlSaldo = "https://mobileapis.manpits.xyz/api/saldo";

  List<Tabungan> get tabungans => _tabungans;

  bool get isLoading => _isLoading;
  Future<void> fetchTabungans(int member) async {
    // if (_isChaced) return;

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
            _isChaced = true;
        Logger().i('${response.statusCode}\n${response.data['message']}');
        notifyListeners();
      } else {
        _isLoading = false;
        Logger().e('${response.statusCode}\n${response.data['message']}');
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
      if (e.response?.statusCode == 406) {
        _tabungans = [];
        // Navigator.of(context).pushReplacementNamed('/homePage');
      }
      throw Exception('Gagal mengambil data dari API');
    }
  }

    Future<int> getSaldo(int anggotaID) async {
    try {
      Response response = await Dio().get('$_apiUrlSaldo/$anggotaID',
          options: Options(
              headers: {"Authorization": "Bearer ${myStorage.read("token")}"}));
      if (response.statusCode == 200) {
        final int saldo = response.data['data']['saldo'];
        Logger().i('${response.statusCode}\n${response.data['message']}');
        return saldo;
      } else {
        Logger().e('${response.statusCode}\n${response.data['message']}');
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
      return 0;
    }
  }

  Future<String> addTabungan(TeamMember member, Tabungan tabungan) async {
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
        _tabungans.add(Tabungan.fromJson(response.data['data']['tabungan']));
        Logger().i('${response.statusCode}\n${response.data['message']}');
        notifyListeners();
        return "success/${response.data['message']}";
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
      return "${e.response?.data['message']}";
    }
  }

  void clearCache() {
    _isChaced = false;
    _tabungans = [];
    notifyListeners();
  }
}

class JenisTransaksiProvider with ChangeNotifier {
  final myStorage = GetStorage();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api/jenistransaksi";
  List<JenisTransaksi> _jenisTransaksiList = [];
  bool _isLoading = false;
  // ignore: unused_field
  bool _isChaced = false;

  List<JenisTransaksi> get jenisTransaksiList => _jenisTransaksiList;
  bool get isLoading => _isLoading;

  Future<void> fetchTransactions() async {
    // if (_isChaced) return;
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
        Logger().i('${response.statusCode}\n${response.data['message']}');
        _isChaced = true;        
        notifyListeners();
      } else {
        Logger().e('${response.statusCode}\n${response.data['message']}');
        throw Exception('Gagal mengambil data dari API');
      }
    } on DioException catch (e) {
      Logger().e('${e.response?.statusCode}\n${e.response?.data['message']}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void clearCache() {
    _isChaced = false;
    _jenisTransaksiList = [];
    notifyListeners();
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
