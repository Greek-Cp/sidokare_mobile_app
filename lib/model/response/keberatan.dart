import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../const/const.dart';

class KeberatanStatus {
  String? code;
  String? message;
  KeberatanStatus({this.code, this.message});
  //rubah id_ppid menjadi id
  static Future<KeberatanStatus> InsertKeberatanPPID(
      {String? id_akun,
      String? alamat,
      String? alasan,
      String? catatan,
      String? idppid}) async {
    Uri url =
        Uri.parse("http://${ApiPoint.BASE_URL}/api/Keberatan/keberatanPPID");
    print(url.toString());
    var hasilResponse = await http.post(url, body: {
      "id_akun": id_akun,
      "alamat": alamat,
      "alasan": alasan,
      "catatan_tambahan": catatan,
      "id": idppid
    });

    var data = json.decode(hasilResponse.body);
    return KeberatanStatus(code: data['code'], message: data['message']);
  }

  static Future<KeberatanStatus> InsertKeberatanAspirasi(
      {String? id_akun,
      String? alamat,
      String? alasan,
      String? catatan,
      String? id_aspirasi}) async {
    Uri url = Uri.parse(
        "http://${ApiPoint.BASE_URL}/api/Keberatan/keberatanAspirasi");
    print(url.toString());
    var hasilResponse = await http.post(url, body: {
      "id_akun": id_akun,
      "alamat": alamat,
      "alasan": alasan,
      "catatan_tambahan": catatan,
      "id_aspirasi": id_aspirasi
    });

    var data = json.decode(hasilResponse.body);
    return KeberatanStatus(code: data['code'], message: data['message']);
  }

  static Future<KeberatanStatus> InsertKeberatanKeluhan(
      {String? id_akun,
      String? alamat,
      String? alasan,
      String? catatan,
      String? id_keluhan}) async {
    Uri url =
        Uri.parse("http://${ApiPoint.BASE_URL}/api/Keberatan/keberatanKeluhan");
    print(url.toString());
    var hasilResponse = await http.post(url, body: {
      "id_akun": id_akun,
      "alamat": alamat,
      "alasan": alasan,
      "catatan_tambahan": catatan,
      "id_keluhan": id_keluhan
    });

    var data = json.decode(hasilResponse.body);
    return KeberatanStatus(code: data['code'], message: data['message']);
  }
}
