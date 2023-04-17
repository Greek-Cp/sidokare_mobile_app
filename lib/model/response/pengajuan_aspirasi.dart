import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../const/const.dart';

class PengajuanAspirasi {
  int? code;
  String? message;
  int? idAkun;
  PengajuanAspirasi({this.code, this.message, this.idAkun});

  static Future<PengajuanAspirasi> InsertAspirasi(String idakun,
      String judulAspirasi, String isiAspirasi, String FileUpload) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/pengajuan/aspirasi");
    var HasilResponse = await http.post(url, body: {
      "id_akun": idakun,
      "judul_aspirasi": judulAspirasi,
      "isi_aspirasi": isiAspirasi,
      "upload_file_pendukung": FileUpload
    });

    var dataa = json.decode(HasilResponse.body);
    return PengajuanAspirasi(code: dataa['code'], message: dataa['message']);
  }

  static Future<void> uploadFileAspirasi(File file) async {
    var uri = Uri.parse(
        'http://${ApiPoint.BASE_URL}/api/pengajuan/uploadfileaspirasi');
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
