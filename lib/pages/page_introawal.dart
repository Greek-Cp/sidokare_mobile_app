import 'package:flutter/material.dart';

class IntroAwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageIntro(),
              _textNganu(),
              SizedBox(
                height: 10,
              ),
              _textDesc(),
              SizedBox(
                height: 20,
              ),
              _button()
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
      children: <Widget>[
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
    return Text(
      "Kami hadir dengan memudahkan segala urusan anda warga Desa Sidokare segeralah bergabung",
      textAlign: TextAlign.center,
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Mulai"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30),
            padding: EdgeInsets.symmetric(vertical: 18)),
      ),
    );
  }
}
