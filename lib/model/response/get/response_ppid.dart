class ResponseModelPPID {
  int? code;
  String? message;
  List<Data>? data;

  ResponseModelPPID({this.code, this.message, this.data});

  ResponseModelPPID.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? idPengajuanPpid;
  int? idAkun;
  String? judulLaporan;
  String? isiLaporan;
  String? asalPelapor;
  String? kategoriPpid;
  String? uploadFilePendukung;

  Data(
      {this.idPengajuanPpid,
      this.idAkun,
      this.judulLaporan,
      this.isiLaporan,
      this.asalPelapor,
      this.kategoriPpid,
      this.uploadFilePendukung});

  Data.fromJson(Map<String, dynamic> json) {
    idPengajuanPpid = json['id_pengajuan_ppid'];
    idAkun = json['id_akun'];
    judulLaporan = json['judul_laporan'];
    isiLaporan = json['isi_laporan'];
    asalPelapor = json['asal_pelapor'];
    kategoriPpid = json['kategori_ppid'];
    uploadFilePendukung = json['upload_file_pendukung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengajuan_ppid'] = this.idPengajuanPpid;
    data['id_akun'] = this.idAkun;
    data['judul_laporan'] = this.judulLaporan;
    data['isi_laporan'] = this.isiLaporan;
    data['asal_pelapor'] = this.asalPelapor;
    data['kategori_ppid'] = this.kategoriPpid;
    data['upload_file_pendukung'] = this.uploadFilePendukung;
    return data;
  }
}