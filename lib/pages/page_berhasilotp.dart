import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';

class berhasilOtp extends StatelessWidget {
  static String? routeName = "/SuccesOtp";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      child: Center(
        child: Padding(
          padding: size.paddingHorizontalAwalFrame,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _gambarSukses(),
                SizedBox(
                  height: 20,
                ),
                ComponentTextTittle("Berhasil Verifikasi"),
                ComponentTextDescription(
                    "Kode yang telah dimasukkan berhasil silahkan login ke akunmu"),
                SizedBox(
                  height: 20,
                ),
                ButtonUtama(PageLogin.routeName, "Lanjut")
              ]),
        ),
      ),
    ));
  }

  Widget _gambarSukses() {
    return Image.asset(
      "assets/sukses.png",
      width: 200,
      height: 200,
    );
  }

  Widget _headerForm() {
    return const Text(
      "Berhasil Verifikasi",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return const Text(
      "Kode yang telah dimasukkan berhasil silahkan login ke akunmu",
      textAlign: TextAlign.center,
    );
  }

  Widget _buttonLanjut() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Lanjut"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
