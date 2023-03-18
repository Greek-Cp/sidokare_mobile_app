import 'package:flutter/material.dart';

class berhasildaftar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                _buttonLanjut()
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
