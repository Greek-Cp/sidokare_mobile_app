import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/const.dart';
import 'package:sidokare_mobile_app/model/response/get/response_aspirasi.dart';
import 'package:sidokare_mobile_app/model/response/get/response_keluhan.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentar.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentarlist.dart';

import 'response_ppid.dart';
import 'package:http/http.dart' as http;

class ControllerAPI {
  static Future<ResponseModelPPID> getStatusPPID(int idAkun) async {
    String? baseURL = ApiPoint.BASE_URL;
    String url = "http://${baseURL}/api/pengajuan/getpengajuan_byid";
    print(url);
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {'id_akun': idAkun.toString()});
    return ResponseModelPPID.fromJson(jsonDecode(res.body));
  }

  static Future<void> downloadFile(
      String url, String savePath, BuildContext context, String Ucapan) async {
    var response = await http.get(Uri.parse(url));
    var file = File(savePath);
    await file.writeAsBytes(response.bodyBytes);
    ToastWidget.ToastSucces(context, "Berhasil Download File");
  }

  static Future<ResponseModelKELUHAN> getStatusKELUHAN(int idAkun) async {
    String? baseURL = ApiPoint.BASE_URL;
    String url = "http://${baseURL}/api/pengajuan/getpengajuan_keluhan_byid";
    print(url);
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {'id_akun': idAkun.toString()});
    return ResponseModelKELUHAN.fromJson(jsonDecode(res.body));
  }

  static Future<ResponseModelASPIRASI> getStatusASPIRASI(int idAkun) async {
    String? baseURL = ApiPoint.BASE_URL;
    String url = "http://${baseURL}/api/pengajuan/get_pengajuan_aspirasi_byid";
    print(url);
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {'id_akun': idAkun.toString()});
    return ResponseModelASPIRASI.fromJson(jsonDecode(res.body));
  }

  static Future<ModelKomentar> buatKomentar(String idAkun, String idBerita,
      String isiKomentar, String waktuBerkomentar) async {
    print("tes idAkun = ${idAkun}");
    print("tes idBerita = ${idBerita}");
    print("tes isiKomentar= ${isiKomentar}");
    print("tes Waktu = ${waktuBerkomentar}");
    String? baseURL = ApiPoint.BASE_URL;
    String url = "http://${baseURL}/api/komentar/buatkomentar";
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {
      'id_akun': idAkun.toString(),
      'id_berita': idBerita,
      'isi_komentar': isiKomentar,
      'waktu_berkomentar': waktuBerkomentar
    });
    print(jsonDecode(res.body));
    return ModelKomentar.fromJson(jsonDecode(res.body));
  }

  static Future<ModelKomentarList> getKomentar(String idBerita) async {
    String? baseURL = ApiPoint.BASE_URL;

    String url = "http://${baseURL}/api/komentar/getkomentar";
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {
      'id_berita': idBerita,
    });
    return ModelKomentarList.fromJson(jsonDecode(res.body));
  }

  static Future<bool> hapusKomentarById(
      {String? id_berita, id_akun, waktu_berkomentar, id_komentar}) async {
    String? baseURL = ApiPoint.BASE_URL;

    var url = "http://${baseURL}/api/komentar/hapus_komentar";
    print(url + "URL");
    var body = {
      'id_berita': id_berita.toString(),
      'id_akun': id_akun.toString(),
      'waktu_berkomentar': waktu_berkomentar.toString(),
      'id_komentar': id_komentar.toString(),
    };
    print("Body : " + body.toString());
    var response = await http.post(Uri.parse(url), body: body);
    print("response" + response.body);
    if (response.statusCode == 200) {
      // Berhasil menghapus komentar
      print('Komentar berhasil dihapus.');
      return true;
    } else {
      // Gagal menghapus komentar
      print('Gagal menghapus komentar.');
      return false;
    }
  }
}
