class ModelKomentar {
  int? code;
  String? message;
  Data? data;

  ModelKomentar({this.code, this.message, this.data});

  ModelKomentar.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? idAkun;
  String? idBerita;
  String? isiKomentar;
  String? waktuBerkomentar;
  int? id;

  Data(
      {this.idAkun,
      this.idBerita,
      this.isiKomentar,
      this.waktuBerkomentar,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    idAkun = json['id_akun'];
    idBerita = json['id_berita'];
    isiKomentar = json['isi_komentar'];
    waktuBerkomentar = json['waktu_berkomentar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_akun'] = this.idAkun;
    data['id_berita'] = this.idBerita;
    data['isi_komentar'] = this.isiKomentar;
    data['waktu_berkomentar'] = this.waktuBerkomentar;
    data['id'] = this.id;
    return data;
  }
}
