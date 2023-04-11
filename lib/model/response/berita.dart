import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sidokare_mobile_app/const/const.dart';

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

Future<List<Berita>> fetchData() async {
  final response = await http.get(Uri.parse('https://example.com/api/berita'));

  if (response.statusCode == 200) {
    // Jika response sukses, convert data JSON ke dalam bentuk List<Berita>
    List<dynamic> data = json.decode(response.body)['data'];
    List<Berita> beritaList = data.map((e) => Berita.fromJson(e)).toList();
    return beritaList;
  } else {
    // Jika response gagal, lempar exception
    throw Exception('Gagal mengambil data dari API');
  }
}

Future<List<Berita>> fetchBeritaKustom(String idKategori) async {
  final response = await http.post(
      Uri.parse('http://${ApiPoint.BASE_URL}/api/berita/specific_berita'),
      body: {"id_kategori": idKategori});

  if (response.statusCode == 200) {
    // print("data = " + response.body);
    final data = jsonDecode(response.body)['data'];

    List<Berita> beritas = [];
    for (var i = 0; i < data.length; i++) {
      beritas.add(Berita.fromJson(data[i]));
    }
    return beritas;
  } else {
    throw Exception('Failed to load data');
  }
}

// Future<List<Berita>> fetchBeritaCustom(String KategoriBerita) async {
//   final response = await http.post(
//       Uri.parse(
//         'http://${ApiPoint.BASE_URL}/api/berita/specific_berita',
//       ),
//       body: {"id_kategori": KategoriBerita});
//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body)['data'];
//     final List<Berita> beritaList =
//         data.map((e) => Berita.fromJson(e)).toList();
//     return beritaList;
//   } else {
//     throw Exception('Failed to fetch berita');
//   }
// }

Future<List<Berita>> fetchBerita() async {
  final response = await http
      .get(Uri.parse('http://${ApiPoint.BASE_URL}/api/berita/get_berita'));

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
