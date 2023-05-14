import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/page_inputotp.dart';
import 'package:sidokare_mobile_app/pages/page_ubahsandi.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LupaSandi extends StatefulWidget {
  static String? routeName = "/lupasandi";
  @override
  State<LupaSandi> createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController input_email = TextEditingController();

  sendMail() async {
    String username = 'e41211358@student.polije.ac.id';
    String password = 'ojmqzqkblieamunx';

    var rng = new Random();
    var code = rng.nextInt(90000) + 10000;
    print("kode nya adalah = ${code}");

    final smtpServer = gmail(username, password);
    String emailPenerima = input_email.text;
    print(emailPenerima + " Get");
    final message = Message()
      ..from = Address(username, 'Reuni321 TEAM')
      ..recipients.add(emailPenerima)
      ..subject = 'Verifikasi Kode Lupa Sandi'
      ..html = "<h1>Kode Verifikasi</h1>\n<h3>Kode Verifikasi == ${code} </h3>";
    Navigator.pushNamed(context, InputOtp.routeName.toString(), arguments: {
      'email': input_email.text.toString(),
      'otp': code.toString(),
      'code_page': "toLupaSandi"
    });
    // print('Message sent: ' + sendReport.toString());
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Navigator.pushNamed(context, InputOtp.routeName.toString(), arguments: {
        'email': input_email.text.toString(),
        'otp': code.toString(),
        'code_page': "toLupaSandi"
      });
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        // ToastWidget.ToastEror(context, ' Format Email Tidak Sesuai');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Padding(
                padding: size.paddingHorizontalAwalFrame,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                      TextFieldImport.TextForm(
                          text_kontrol: input_email,
                          hintText: "Masukkan Email",
                          labelName: "Email",
                          pesanValidasi: "Email"),
                      ButtonForm("Lanjut", _formKey, () {
                        HttpStatefull.checkAkunExist(email: input_email.text)
                            .then((value) => {
                                  if (value.code == 200)
                                    {sendMail()}
                                  else
                                    {
                                      ToastWidget.ToastEror(context,
                                          "Akun Tidak Ditemukan", "Selamat")
                                    }
                                });
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _HeaderText() {
    return const Text(
      "Lupa Kata Sandi",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: 28),
    );
  }

  Widget _DescHeaderText() {
    return const Text(
      "Silahkan atur ulang kata sandi",
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

  Widget _inputEmailuser() {
    return Column(
      children: <Widget>[
        // ignore: prefer_const_constructors
        Align(
          alignment: Alignment.topLeft,
        ),
        SizedBox(
          height: 10,
        ),
        // TextFieldPassword(),
        TextFieldImport.TextForm(
          labelName: "Email",
        ),
      ],
    );
  }

  Widget _ButtonLupa() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_formKey.currentState!.validate()) {
              sendMail();
              // Navigator.pushNamed(context, InputOtp.routeName.toString());
            }
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
