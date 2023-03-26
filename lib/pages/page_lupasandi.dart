import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';
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
    String username = 'romu2ateam@gmail.com';
    String password = 'uqrecynmrxlqpper';

    final smtpServer = gmail(username, password);
    String emailPenerima = input_email.text;
    print(emailPenerima + " Get");
    final message = Message()
      ..from = Address(username, 'Reuni321 TEAM')
      ..recipients.add(emailPenerima)
      ..subject = 'Verifikasi Kode Lupa Sandi'
      ..html = "<h1>Kode Verifikasi</h1>\n<h3>Kode Verifikasi == 66666 </h3>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Navigator.pushNamed(context, InputOtp.routeName.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        ToastWidget.ToastEror(context, ' Format Email Tidak Sesuai');
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
                        height: 20,
                      ),
                      _HeaderText(),
                      _DescHeaderText(),
                      _ImageLupaKataSandi(),
                      TextFieldImport.TextForm(
                          text_kontrol: input_email,
                          hintText: "Masukkan Email",
                          labelName: "Email",
                          pesanValidasi: "Email"),
                      _ButtonLupa()
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
      "Silahkan atur ulang passwordmu",
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
