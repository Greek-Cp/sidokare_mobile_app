import 'dart:io';

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
      String userRT,
      String userRW,
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
      "upload_file_pendukung": UploadFile,
      "RT": userRT,
      "RW": userRW
    });

    var data = json.decode(HasilResponse.body);
    return PengajuhanKeluhan(code: data['code'], message: data['message']);
  }

  static Future<void> uploadFileKeluhan(File file) async {
    var uri = Uri.parse(
        'http://${ApiPoint.BASE_URL}/api/pengajuan/uploadfilekeluhan');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully || Keluhan');
    } else {
      print('Error uploading file: ${response.reasonPhrase}');
    }
  }
}
