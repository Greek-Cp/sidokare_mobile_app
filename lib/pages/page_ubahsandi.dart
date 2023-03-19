import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import '../const/list_color.dart';

class UbahSandi extends StatefulWidget {
  static String? routeName = "/UbahSandi";
  @override
  State<UbahSandi> createState() => _UbahSandiState();
}

class _UbahSandiState extends State<UbahSandi> {
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
              _HeaderText(),
              _DescHeaderText(),
              _ImageLupaKataSandi(),
              _inputEmailuser("Masukkan Kata Sandimu", "kata Sandi"),
              SizedBox(
                height: 10,
              ),
              _inputEmailuser(
                  "Masukkan Ulang Kata Sandimu", "Konfirmasi kata Sandi"),
              _ButtonUbah()
            ],
          ),
        ),
      )),
    );
  }

  Widget _HeaderText() {
    return const Text(
      "Ubah Sandi",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    );
  }

  Widget _DescHeaderText() {
    return const Text(
      "Silahkan masukkan kode otp ",
      style: TextStyle(fontFamily: fontfix.DmSansBruh, fontSize: 16),
    );
  }

  Widget _ImageLupaKataSandi() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        "assets/imageubahsandi.png",
        width: 260,
        height: 256,
      ),
    );
  }

  Widget _inputEmailuser(
    String hint,
    String labelAtas,
  ) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            labelAtas,
            style: TextStyle(fontFamily: fontfix.DmSansBruh),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontFamily: fontfix.DmSansBruh),
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: ListColor.warnaBiruSidoKare,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
      ],
    );
  }

  Widget _ButtonUbah() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Ubah Kata Sandi",
          style: TextStyle(fontFamily: fontfix.DmSansBruh),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55)),
      ),
    );
  }
}
