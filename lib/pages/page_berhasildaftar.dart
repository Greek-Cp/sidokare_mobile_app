import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _gambarSukses(),
                SizedBox(
                  height: 20,
                ),
                _headerForm(),
                _descSukses(),
                SizedBox(
                  height: 20,
                ),
                _buttonLanjut(context)
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
      "Berhasil mengubah sandi",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return const Text(
      "Akun telah berhasil diatur kata sandi , anda dapat menggunakan sandi baru",
      textAlign: TextAlign.center,
    );
  }

  Widget _buttonLanjut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PageLogin.routeName.toString());
        },
        child: Text("Lanjut"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
