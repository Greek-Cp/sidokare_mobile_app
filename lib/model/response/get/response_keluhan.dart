class ResponseModelKELUHAN {
  int? code;
  String? message;
  List<Data>? data;

  ResponseModelKELUHAN({this.code, this.message, this.data});

  ResponseModelKELUHAN.fromJson(Map<String, dynamic> json) {
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
  String? idPengajuanKeluhan;
  int? idAkun;
  String? judulLaporan;
  String? isiLaporan;
  String? asalPelapor;
  String? lokasiKejadian;
  String? kategoriLaporan;
  String? tanggalKejadian;
  String? uploadFilePendukung;

  Data(
      {this.idPengajuanKeluhan,
      this.idAkun,
      this.judulLaporan,
      this.isiLaporan,
      this.asalPelapor,
      this.lokasiKejadian,
      this.kategoriLaporan,
      this.tanggalKejadian,
      this.uploadFilePendukung});

  Data.fromJson(Map<String, dynamic> json) {
    idPengajuanKeluhan = json['id_pengajuan_keluhan'];
    idAkun = json['id_akun'];
    judulLaporan = json['judul_laporan'];
    isiLaporan = json['isi_laporan'];
    asalPelapor = json['asal_pelapor'];
    lokasiKejadian = json['lokasi_kejadian'];
    kategoriLaporan = json['kategori_laporan'];
    tanggalKejadian = json['tanggal_kejadian'];
    uploadFilePendukung = json['upload_file_pendukung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengajuan_keluhan'] = this.idPengajuanKeluhan;
    data['id_akun'] = this.idAkun;
    data['judul_laporan'] = this.judulLaporan;
    data['isi_laporan'] = this.isiLaporan;
    data['asal_pelapor'] = this.asalPelapor;
    data['lokasi_kejadian'] = this.lokasiKejadian;
    data['kategori_laporan'] = this.kategoriLaporan;
    data['tanggal_kejadian'] = this.tanggalKejadian;
    data['upload_file_pendukung'] = this.uploadFilePendukung;
    return data;
  }
}
