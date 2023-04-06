import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpStatefull {
  int? code;
  int? id_akun;
  String? message;
  String? email, password, nomor_telepon, username;
  String? nama_lengkap;
  String? kode_otp;

  HttpStatefull(
      {this.code,
      this.message,
      this.nama_lengkap,
      this.kode_otp,
      this.id_akun});
  static Future<HttpStatefull> registerAkun(
      String email,
      String password,
      String username,
      String nomor_telepon,
      String kode_otp,
      String nama_lengkap) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/register");
    var HasilResponse = await http.post(url, body: {
      "email": email,
      "username": username,
      "nomor_telepon": nomor_telepon,
      "password": password,
      "role": "User",
      "otp": kode_otp,
      "nama": nama_lengkap
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
        nama_lengkap: data["data"]["akun"]["nama"],
        id_akun: data["data"]["akun"]["id_akun"]);
  }

  static Future<HttpStatefull> ubahSandi(String email, String password) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/updatePassword");
    var HasilResponse =
        await http.post(url, body: {'email': email, "password": password});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }

  static Future<HttpStatefull> verifikasiAkun(String email) async {
    Uri url = Uri.parse("http://127.0.0.1:8000/api/akun/verifikasi_akun");
    var HasilResponse = await http.post(url, body: {'email': email});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }
}
