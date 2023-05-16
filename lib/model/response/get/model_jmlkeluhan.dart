import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../const/const.dart';

class KeberatanKeluhan {
  final String code;
  final String jumlahKeberatanKeluhan;
  KeberatanKeluhan({required this.code, required this.jumlahKeberatanKeluhan});

  factory KeberatanKeluhan.fromJson(Map<String, dynamic> json) {
    return KeberatanKeluhan(
        code: json['code'].toString(),
        jumlahKeberatanKeluhan: json['data'].toString());
  }

  static Future<KeberatanKeluhan> getJumlahKeberatanKeluhan(
      {String? idAKun, String? idKeluhan}) async {
    var response = await http.post(
        Uri.parse(
            'http://${ApiPoint.BASE_URL}/api/Keberatan/jumlahKeberatanKeluhan'),
        body: {'id_akun': idAKun, 'id_keluhan': idKeluhan});
    var jsonResponse = json.decode(response.body);
    print("Data Jumlah : ${jsonResponse}");
    return KeberatanKeluhan.fromJson(jsonResponse);
  }
}
