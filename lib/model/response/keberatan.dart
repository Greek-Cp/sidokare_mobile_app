import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../const/const.dart';

class KeberatanStatus {
  String? code;
  String? message;
  KeberatanStatus({this.code, this.message});

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
      "id_ppid": idppid
    });

    var data = json.decode(hasilResponse.body);
    return KeberatanStatus(code: data['code'], message: data['message']);
  }
}
