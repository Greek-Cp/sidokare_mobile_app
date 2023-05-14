class ResponseModelASPIRASI {
  int? code;
  String? message;
  List<Data>? data;

  ResponseModelASPIRASI({this.code, this.message, this.data});

  ResponseModelASPIRASI.fromJson(Map<String, dynamic> json) {
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
  String? idPengajuanAspirasi;
  int? idAkun;
  String? status;
  String? judulAspirasi;
  String? isiAspirasi;
  String? dokumenOutput;
  String? uploadFilePendukung;

  Data(
      {this.idPengajuanAspirasi,
      this.idAkun,
      this.status,
      this.dokumenOutput,
      this.judulAspirasi,
      this.isiAspirasi,
      this.uploadFilePendukung});

  Data.fromJson(Map<String, dynamic> json) {
    idPengajuanAspirasi = json['id_pengajuan_aspirasi'];
    idAkun = json['id_akun'];
    status = json['status'];
    dokumenOutput = json['doc_hasil_ppid'];
    judulAspirasi = json['judul_aspirasi'];
    isiAspirasi = json['isi_aspirasi'];
    uploadFilePendukung = json['upload_file_pendukung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengajuan_aspirasi'] = this.idPengajuanAspirasi;
    data['id_akun'] = this.idAkun;
    data['judul_aspirasi'] = this.judulAspirasi;
    data['isi_aspirasi'] = this.isiAspirasi;
    data['upload_file_pendukung'] = this.uploadFilePendukung;
    return data;
  }
}
