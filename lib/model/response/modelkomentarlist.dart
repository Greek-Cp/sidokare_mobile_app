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
  String? idAkun;
  String? idBerita;
  String? isiKomentar;
  String? waktuBerkomentar;
  String? namaPengkomen;
  String? profilePicKomen;

  DataBerita(
      {this.idKomentar,
      this.idAkun,
      this.idBerita,
      this.isiKomentar,
      this.waktuBerkomentar,
      this.namaPengkomen,
      this.profilePicKomen});
  //rubah id_berita => id

  DataBerita.fromJson(Map<String, dynamic> json) {
    idKomentar = json['id_komentar'];
    idAkun = json['id_akun'];
    idBerita = json['id'];
    isiKomentar = json['isi_komentar'];
    waktuBerkomentar = json['waktu_berkomentar'];
    namaPengkomen = json['nama'];
    profilePicKomen = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_komentar'] = this.idKomentar;
    data['id_akun'] = this.idAkun;
    data['id'] = this.idBerita;
    data['isi_komentar'] = this.isiKomentar;
    data['waktu_berkomentar'] = this.waktuBerkomentar;
    return data;
  }
}
