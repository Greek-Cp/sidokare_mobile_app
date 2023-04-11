import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../const/const.dart';

class PengajuanPPID {
  int? code;
  String? message;
  String? idPengajuan;
  int? idAkun;
  String? JudulLaporan;
  String? isiLaporan;
  String? asalLaporan;
  String? kategoriPPID;
  String? File;

  PengajuanPPID({
    this.code,
    this.message,
    this.idAkun,
  });

  static Future<PengajuanPPID> InsertDataPPID(
      String idAkun,
      String JudulLaporan,
      String isiLaporan,
      String asalLaporan,
      String kategoriPPID,
      String File) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/pengajuan/ppid");
    var HasilResponse = await http.post(url, body: {
      "id_akun": idAkun,
      "judul_laporan": JudulLaporan,
      "isi_laporan": isiLaporan,
      "asal_pelapor": asalLaporan,
      "kategori_ppid": kategoriPPID,
      "upload_file_pendukung": File
    });

    var dataa = json.decode(HasilResponse.body);
    return PengajuanPPID(code: dataa['code'], message: dataa['message']);
  }
}
