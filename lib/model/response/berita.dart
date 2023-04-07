import 'dart:convert';
import 'package:http/http.dart' as http;

class Berita {
  final int idBerita;
  final int idAkun;
  final String tanggalPublikasi;
  final String idKategori;
  final String isiBerita;
  final String foto;
  final String unggahFileLain;
  final String judulBerita;

  Berita({
    required this.idBerita,
    required this.idAkun,
    required this.tanggalPublikasi,
    required this.idKategori,
    required this.isiBerita,
    required this.foto,
    required this.unggahFileLain,
    required this.judulBerita,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      idBerita: json['id_berita'],
      idAkun: json['id_akun'],
      tanggalPublikasi: json['tanggal_publikasi'],
      idKategori: json['id_kategori'],
      isiBerita: json['isi_berita'],
      foto: json['foto'],
      unggahFileLain: json['unggah_file_lain'],
      judulBerita: json['judul_berita'],
    );
  }
}

Future<List<Berita>> fetchBerita() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/berita/get_berita'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    List<dynamic> beritaListJson = jsonData['data'];
    List<Berita> beritaList =
        beritaListJson.map((json) => Berita.fromJson(json)).toList();
    return beritaList;
  } else {
    throw Exception('Failed to load data');
  }
}
