import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';

class LupaSandi extends StatefulWidget {
  static String? routeName = "/lupasandi";
  @override
  State<LupaSandi> createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: size.paddingHorizontalAwalFrame,
            child: Form(
              key: _formKey,
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
        // ignore: prefer_const_constructors
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
        // TextFieldPassword(),
        TextFieldImport.TextForm(),
      ],
    );
  }

  Widget _ButtonLupa() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_formKey.currentState!.validate()) {}
          });
        },
        child: Text(
          "Lanjut",
          style: TextStyle(fontFamily: fontfix.DmSansBruh),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55)),
      ),
    );
  }
}
