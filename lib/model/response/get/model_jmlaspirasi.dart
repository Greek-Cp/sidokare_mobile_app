import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../const/const.dart';

class KeberatanAspirasi {
  final String code;
  final String JumlahKeberatanAspirasi;

  KeberatanAspirasi(
      {required this.code, required this.JumlahKeberatanAspirasi});
  factory KeberatanAspirasi.fromJson(Map<String, dynamic> json) {
    return KeberatanAspirasi(
        code: json['code'].toString(),
        JumlahKeberatanAspirasi: json['data'].toString());
  }

  static Future<KeberatanAspirasi> getJumlahKeberatanAspirasi(
      {String? idAKun, String? id_aspirasi}) async {
    var response = await http.post(
        Uri.parse(
            'http://${ApiPoint.BASE_URL}/api/Keberatan/jumlahKeberatanAspirasi'),
        body: {'id_akun': idAKun, 'id_aspirasi': id_aspirasi});
    var jsonResponse = json.decode(response.body);
    print("Data Jumlah : ${jsonResponse}");
    return KeberatanAspirasi.fromJson(jsonResponse);
  }
}
