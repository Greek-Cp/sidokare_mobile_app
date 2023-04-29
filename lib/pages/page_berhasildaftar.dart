import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class berhasildaftar extends StatelessWidget {
  static String? routeName = "/SuccesDaftar";
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
                _descSukses(),
                SizedBox(
                  height: 20,
                ),
                _buttonLanjut()
              ]),
        ),
      ),
    ));
  }

  Widget _gambarSukses() {
    return Lottie.asset(
      "assets/done_animasi.json",
      width: 200,
      height: 200,
    );
  }

  Widget _headerForm() {
    return const Text(
      "Berhasil Daftar",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return const Text(
      "Akun yang telah dimasukkan berhasil silahkan login ke akunmu",
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
