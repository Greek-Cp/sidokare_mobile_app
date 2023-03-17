import 'package:flutter/material.dart';

class berhasildaftar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: <Widget>[
            _gambarSukses(),
            _headerForm(),
            _descSukses(),
            _buttonLanjut()
          ]),
        ),
      ),
    ));
  }

  Widget _gambarSukses() {
    return Image.asset(
      "assets/sukses.png",
      width: 250,
      height: 250,
    );
  }

  Widget _headerForm() {
    return Text(
      "Berhasil Daftar",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return Text(
      "Akun yang telah dimasukkan berhasil silahkan login ke akunmu",
      textAlign: TextAlign.center,
    );
  }

  Widget _buttonLanjut() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Lanjut"),
      style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(30)),
    );
  }
}
