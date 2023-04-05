import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpStatefull {
  int? code;
  String? message;
  String? email, password, nomor_telepon, username;
  String? nama_lengkap;
  String? kode_otp;

  HttpStatefull({this.code, this.message, this.nama_lengkap, this.kode_otp});
  static Future<HttpStatefull> registerAkun(String email, String password,
      String username, String nomor_telepon, String kode_otp) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/register");
    var HasilResponse = await http.post(url, body: {
      "email": email,
      "username": username,
      "nomor_telepon": nomor_telepon,
      "password": password,
      "role": "User",
      "otp": kode_otp
    });
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }

  static Future<HttpStatefull> loginAkun(String email, String Password) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/login");
    var HasilResponse =
        await http.post(url, body: {'email': email, 'password': Password});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(
      code: data['code'],
      message: data['message'],
    );
  }

  static Future<HttpStatefull> verifikasiAkun(String email) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/verifikasi_akun");
    var HasilResponse = await http.post(url, body: {'email': email});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }
}
