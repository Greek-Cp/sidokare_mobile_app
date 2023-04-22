class ModelKomentarList {
  int? code;
  String? message;
  List<DataBerita>? data;

  ModelKomentarList({this.code, this.message, this.data});

  ModelKomentarList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataBerita>[];
      json['data'].forEach((v) {
        data!.add(new DataBerita.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBerita {
  String? idKomentar;
  int? idAkun;
  int? idBerita;
  String? isiKomentar;
  String? waktuBerkomentar;

  DataBerita(
      {this.idKomentar,
      this.idAkun,
      this.idBerita,
      this.isiKomentar,
      this.waktuBerkomentar});

  DataBerita.fromJson(Map<String, dynamic> json) {
    idKomentar = json['id_komentar'];
    idAkun = json['id_akun'];
    idBerita = json['id_berita'];
    isiKomentar = json['isi_komentar'];
    waktuBerkomentar = json['waktu_berkomentar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_komentar'] = this.idKomentar;
    data['id_akun'] = this.idAkun;
    data['id_berita'] = this.idBerita;
    data['isi_komentar'] = this.isiKomentar;
    data['waktu_berkomentar'] = this.waktuBerkomentar;
    return data;
  }
}
