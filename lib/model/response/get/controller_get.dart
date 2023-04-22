import 'dart:convert';

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
    String? baseURL = ApiPoint.BASE_URL;
    String url = "http://${baseURL}/api/komentar/buatkomentar";
    Uri uri = Uri.parse(url);
    var res = await http.post(uri, body: {
      'id_akun': idAkun.toString(),
      'id_berita': idBerita,
      'isi_komentar': isiKomentar,
      'waktu_berkomentar': waktuBerkomentar
    });
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
}
