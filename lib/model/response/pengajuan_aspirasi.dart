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
}
