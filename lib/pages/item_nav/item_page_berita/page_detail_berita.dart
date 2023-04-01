import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class PageDetailBerita extends StatefulWidget {
  @override
  State<PageDetailBerita> createState() => _PageDetailBeritaState();
}

class _PageDetailBeritaState extends State<PageDetailBerita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController getNama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: ListView(
            children: [
              _Image("assets/laptop.jpg"),
              _HeaderJudul(),
              _ListMbu(),
              _isiBerita(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 2,
                  height: 2,
                ),
              ),
              _isiKomen()
            ],
          ),
        );
      },
    );
  }

  Widget _Image(String urlImage) {
    return Image(
      image: AssetImage(urlImage),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  }

  Widget _HeaderJudul() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Hati - hati!! BMD akan mengadakan lomba Agustusan",
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: size.HeaderText),
      ),
    );
  }

  Widget _ListMbu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: Color.fromARGB(255, 236, 241, 255),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text("Pemerintahan Desa"),
            ),
          ),
          Text("20 Oct, 2023"),
          CircleAvatar(
            radius: 10,
          ),
          Text("Deva Arie")
        ],
      ),
    );
  }

  Widget _isiBerita() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        "Para ibu-ibu muda Desa Sidokare telah menciptkan resep makan tradisional untuk merayakan lomba Momen peringatan Hari Kemerdekaan RI sering dimeriahkan dengan beragam lomba, mulai dari tingkat RT/RW sampai di sekolah dan kantor. Tujuan lomba ini biasanya menguji kekompakan warga.Jika Anda menjadi panitia dan masih bingung ingin mengadakan apa, simak 20 ide lomba 17 Agustus yang seru dan menarik berikut ini",
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _isiKomen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Aktifitas Lainnya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.HeaderText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Nama",
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Masukkan Komentar",
                  ),
                ),
              ),
              ButtonForm("Kirim Komentar", _formKey, KirimPesan())
            ],
          )),
    );
  }

  KirimPesan() {}
}
