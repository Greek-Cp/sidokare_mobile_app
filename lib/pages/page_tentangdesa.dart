import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';

class TentangDesaSidokare extends StatelessWidget {
  static String? routeName = "/TentangSidokare";
  String? woi =
      """Desa Sidokare adalah sebuah desa yang menjadi bagian wilayah dalam cakupan Kecamatan Rejoso, Kabupaten Nganjuk, Provinsi Jawa Timur, Indonesia.

Dengan jumlah total penduduk sebanyak 3.385 jiwa, terdiri dari 1.697 jiwa berjenis kelamin laki-laki dan 1.688 jiwa berjenis kelamin perempuan (berdasarkan data BPS Kabupaten Nganjuk tahun 2017/2018).

Desa Sidokare terdiri dari 1 dusun, yaitu :
Dusun Sidokare
 """;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: ComponentTextTittle("Desa Sidokare"),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("assets/sidokaredesa.jpg",
                      fit: BoxFit.cover)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  "${woi}",
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
