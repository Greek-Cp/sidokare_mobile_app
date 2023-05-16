import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../const/const.dart';

class KeberatanPPID {
  final String code;
  final String jumlahKeberatanPPID;

  KeberatanPPID({required this.code, required this.jumlahKeberatanPPID});

  factory KeberatanPPID.fromJson(Map<String, dynamic> json) {
    return KeberatanPPID(
        code: json['code'].toString(),
        jumlahKeberatanPPID: json['data'].toString());
  }

  static Future<KeberatanPPID> getJumlahKeberatanPPID(
      {String? idAKun, String? idppid}) async {
    var response = await http.post(
        Uri.parse('http://${ApiPoint.BASE_URL}/api/Keberatan/jumlahKeberatan'),
        body: {'id_akun': idAKun, 'id_ppid': idppid});
    var jsonResponse = json.decode(response.body);
    print("Data Jumlah : ${jsonResponse}");
    return KeberatanPPID.fromJson(jsonResponse);
  }
}
