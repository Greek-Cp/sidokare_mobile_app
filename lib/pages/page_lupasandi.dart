import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import '../const/list_color.dart';

class LupaSandi extends StatefulWidget {
  static String? routeName = "/lupasandi";
  @override
  State<LupaSandi> createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
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
                _inputEmailuser(),
                _ButtonLupa()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _HeaderText() {
    return const Text(
      "Lupa Kata Sandi",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    );
  }

  Widget _DescHeaderText() {
    return const Text(
      "Silahkan atur ulang passwordmu",
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

  Widget _inputEmailuser() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Email",
            style: TextStyle(fontFamily: fontfix.DmSansBruh),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Masukkan Emailmud",
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

  Widget _ButtonLupa() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Lanjut",
          style: TextStyle(fontFamily: fontfix.DmSansBruh),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55)),
      ),
    );
  }
}
