import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import '../const/list_color.dart';

class UbahSandi extends StatefulWidget {
  static String? routeName = "/UbahSandi";
  @override
  State<UbahSandi> createState() => _UbahSandiState();
}

class _UbahSandiState extends State<UbahSandi> {
  bool _passwordvisible = false;
  bool _passwordvisible2 = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputSandi = TextEditingController();
  TextEditingController inputSandi2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordvisible = false;
    _passwordvisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Container(
              child: SafeArea(
            child: Center(
              child: Padding(
                padding: size.paddingHorizontalAwalFrame,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () => {Navigator.pop(context)},
                                icon: Icon(Icons.arrow_back)),
                          ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      _HeaderText(),
                      _DescHeaderText(),
                      _ImageLupaKataSandi(),
                      TextFieldPassword(inputSandi2, "Masukkan Kata Sandimu",
                          _passwordvisible2, "kata Sandi", "Harap disi"),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFieldPassword(
                          inputSandi,
                          "Masukkan Ulang Kata Sandimu",
                          _passwordvisible,
                          "Konfirmasi kata Sandi",
                          "Harap disi"),
                      _ButtonUbah()
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }

  Widget _HeaderText() {
    return const Text(
      "Ubah Sandi",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: 28),
      textAlign: TextAlign.center,
    );
  }

  Widget _DescHeaderText() {
    return const Text(
      "Silahkan masukkan kode otp ",
      style: TextStyle(fontFamily: fontfix.DmSansBruh, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  Widget _ImageLupaKataSandi() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          "assets/imageubahsandi.png",
          width: 260,
          height: 256,
        ),
      ),
    );
  }

  Widget _inputSandiSatu(
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
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: !_passwordvisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordvisible = !_passwordvisible;
                    });
                  },
                  icon: Icon(
                    _passwordvisible ? Icons.visibility : Icons.visibility_off,
                    color: ListColor.warnaBiruSidoKare,
                  )),
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

  Widget _inputSandiDua(
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
          obscureText: !_passwordvisible2,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordvisible2 = !_passwordvisible2;
                    });
                  },
                  icon: Icon(
                    _passwordvisible2 ? Icons.visibility : Icons.visibility_off,
                    color: ListColor.warnaBiruSidoKare,
                  )),
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
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Text(
          "Ubah Kata Sandi",
          style: TextStyle(fontFamily: fontfix.DmSansBruh),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55)),
      ),
    );
  }
}
