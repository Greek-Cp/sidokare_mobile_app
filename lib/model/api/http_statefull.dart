import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sidokare_mobile_app/const/const.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class HttpStatefull {
  int? code;
  int? id_akun;
  String? message;
  String? email, password, nomor_telepon, username;
  String? nama_lengkap;
  String? kode_otp;
  String? nik;
  String? namaProfile;

  HttpStatefull(
      {this.code,
      this.message,
      this.nama_lengkap,
      this.kode_otp,
      this.id_akun,
      this.nik,
      this.namaProfile,
      this.email,
      this.nomor_telepon});
  static Future<HttpStatefull> registerAkun(
      String email,
      String password,
      String username,
      String nomor_telepon,
      String kode_otp,
      String nama_lengkap) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/akun/register");
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
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/akun/login");
    var HasilResponse =
        await http.post(url, body: {'email': email, 'password': Password});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(
        code: data['code'],
        message: data['message'],
        nama_lengkap: data["data"]["akun"]["nama"],
        id_akun: data["data"]["akun"]["id_akun"],
        nik: data["data"]["akun"]["nik"],
        namaProfile: data["data"]["akun"]["profile_img"],
        email: data["data"]["akun"]["email"],
        nomor_telepon: data["data"]["akun"]["nomor_telepon"]);
  }

  static Future<HttpStatefull> ubahSandi(String email, String password) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/akun/updatePassword");
    var HasilResponse =
        await http.post(url, body: {'email': email, "password": password});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }

  static Future<HttpStatefull> UpdateProfileSaja(
      {String? idAkun, String? namaProfile, String? NomorTelp}) async {
    Uri url =
        Uri.parse("http://${ApiPoint.BASE_URL}/api/Profile/UpdateDataSaja");
    var hasilResponse = await http.post(url, body: {
      "id_akun": idAkun,
      "nama": namaProfile,
      "nomor_telepon": NomorTelp
    });
    var data = json.decode(hasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }

  static Future<HttpStatefull> verifikasiAkun(String email) async {
    Uri url = Uri.parse("http://${ApiPoint.BASE_URL}/api/akun/verifikasi_akun");
    var HasilResponse = await http.post(url, body: {'email': email});
    var data = json.decode(HasilResponse.body);
    return HttpStatefull(code: data['code'], message: data['message']);
  }

  // fungsi untuk mengirim request text dan upload file
  static Future<void> sendRequestWithFile(
      {String? id_akun,
      String? delPic,
      String? nama,
      String? nomorHp,
      File? file}) async {
    var request = http.MultipartRequest('POST',
        Uri.parse("http://${ApiPoint.BASE_URL}/api/Profile/UpdateDelete"));

    // tambahkan text sebagai field pada request
    request.fields['profile_img'] = delPic.toString();
    request.fields['id_akun'] = id_akun.toString();
    request.fields['nama'] = nama.toString();
    request.fields['nomor_telepon'] = nomorHp.toString();

    // tambahkan file sebagai field pada request
    var mimeType = lookupMimeType(file!.path);
    var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
    var fileLength = await file.length();
    var multipartFile = http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: file.path.split('/').last,
      contentType: MediaType.parse(mimeType!),
    );
    request.files.add(multipartFile);

    // kirim request dan tunggu responsenya
    var response = await http.Response.fromStream(await request.send());
    print("Tes Image Bruh" + response.body);
  }
}
