import 'package:flutter/material.dart';
import './page_login.dart';

class IntroAwal extends StatelessWidget {
  static String? routeName = "/introawal";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageIntro(),
              _textNganu(),
              const SizedBox(
                height: 10,
              ),
              _textDesc(),
              const SizedBox(
                height: 20,
              ),
              _button(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageIntro() {
    return Image.asset(
      "assets/intro1.png",
      width: 375,
      height: 363,
    );
  }

  Widget _textNganu() {
    return Column(
      children: const <Widget>[
        Text(
          "Masalah Teratasi",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text("Makmurkan Desa",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _textDesc() {
    return const Text(
      "Kami hadir dengan memudahkan segala urusan anda warga Desa Sidokare segeralah bergabung",
      textAlign: TextAlign.center,
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PageLogin.routeName.toString());
        },
        child: Text("Mulai"),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(30),
            padding: const EdgeInsets.symmetric(vertical: 18)),
      ),
    );
  }
}
