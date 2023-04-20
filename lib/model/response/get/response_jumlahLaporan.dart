import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../const/const.dart';

class JumlahLaporan {
  String? jumlahAspirasi;
  String? jumlahKeluhan;
  String? ppid;
  String? total;

  JumlahLaporan(
      {this.jumlahAspirasi, this.jumlahKeluhan, this.ppid, this.total});

  static Future<JumlahLaporan> getLaporan() async {
    Uri url =
        Uri.parse("http://${ApiPoint.BASE_URL}/api/jumlahLaporan/Jumlahhnya");
    var HasilResponse = await http.get(url);
    var data = (json.decode(HasilResponse.body))['data'];
    print("Laporan data nya :: ${data.toString()} ");
    return JumlahLaporan(
        jumlahAspirasi: data['JumlahAspirasi'].toString(),
        jumlahKeluhan: data['JumlahKeluhan'].toString(),
        ppid: data['JumlahPPID'].toString(),
        total: data['TotalLaporan'].toString());
  }

  static Future<Map<String, dynamic>> getDataLaporan() async {
    Uri url =
        Uri.parse("http://${ApiPoint.BASE_URL}/api/jumlahLaporan/Jumlahhnya");
    var HasilResponse = await http.get(url);
    var data = (json.decode(HasilResponse.body))['data'];
    print("Laporan data nya :: ${data.toString()} ");
    return data;
  }
}
