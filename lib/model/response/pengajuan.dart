import 'dart:io';

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

  PengajuanPPID({
    this.code,
    this.message,
    this.idAkun,
  });

  static Future<PengajuanPPID> InsertDataPPID(
      {String? idAkun,
      String? nama_pelapor,
      String? noTelp,
      String? emailUser,
      String? JudulLaporan,
      String? isiLaporan,
      String? asalLaporan,
      String? kategoriPPID,
      String? RT,
      String? RW,
      String? File}) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/pengajuan/ppid");
    var HasilResponse = await http.post(url, body: {
      "id_akun": idAkun,
      "nama_pelapor": nama_pelapor,
      "no_telfon": noTelp,
      "email": emailUser,
      "judul_laporan": JudulLaporan,
      "isi_laporan": isiLaporan,
      "Alamat": asalLaporan,
      "kategori_ppid": kategoriPPID,
      "upload_file_pendukung": File,
      "RT": RT,
      "RW": RW
    });

    var dataa = json.decode(HasilResponse.body);
    return PengajuanPPID(code: dataa['code'], message: dataa['message']);
  }

  static Future<void> uploadFilePPID(File file) async {
    var uri =
        Uri.parse('http://${ApiPoint.BASE_URL}/api/pengajuan/uploadfileppid');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('Error uploading file: ${response.reasonPhrase}');
    }
  }
}
