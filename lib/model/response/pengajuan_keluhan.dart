import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../const/const.dart';

class PengajuhanKeluhan {
  int? code;
  String? message;
  int? idAkun;

  PengajuhanKeluhan({this.code, this.message, this.idAkun});

  static Future<PengajuhanKeluhan> InsertDataKeluhan(
      String idAkun,
      String JudulLaporan,
      String isiLaporan,
      String asalPelapor,
      String lokasiKejadian,
      String KategoriLaporan,
      String tanggalKejadian,
      String UploadFile) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/pengajuan/keluhan");
    var HasilResponse = await http.post(url, body: {
      "id_akun": idAkun,
      "judul_laporan": JudulLaporan,
      "isi_laporan": isiLaporan,
      "asal_pelapor": asalPelapor,
      "lokasi_kejadian": lokasiKejadian,
      "kategori_laporan": KategoriLaporan,
      "tanggal_kejadian": tanggalKejadian,
      "upload_file_pendukung": UploadFile
    });

    var data = json.decode(HasilResponse.body);
    return PengajuhanKeluhan(code: data['code'], message: data['message']);
  }
}
