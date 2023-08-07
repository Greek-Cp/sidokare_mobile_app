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

import '../component/Helper.dart';
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
    String password = 'ltddukvjccanwukp';

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
      ..html = """<!DOCTYPE html>
      <html>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <head>
    <style>

      body{
        background: #E5E5E5 !important ; 
        font-family: 'Work Sans', sans-serif;
      }
      .button{
        background: #1877F2; 
        color: #fff !important ; 
        border-radius: 3px; 
        display: block;
        text-decoration: none;
        padding: 15px;
        font-size: 16px; 
        text-align: center;
        margin-top: 60px;
      }
      .main-container{
        max-width: 29.375em;  
        width: 100%; 
        border-radius: 10px; 
        background: #ffffff;
        margin: 0 auto;
        border: #fff; 
      }

      .content{
        width: 80%;
        min-width: 23.9375em; 
        margin: 2em auto;
        font-size: 12px;
      }

      .link{
        color: #000; text-decoration: none;text-align: center;margin-bottom: 10px;
      }

      .title-text{
        font-weight: 600;
      }

      .header{
        font-size: 12px;
        font-weight: 700; 
        padding-bottom: .5em; 
        letter-spacing: 0.08em;
      }

      .welcome-message{
        text-align: center;
        font-weight: bold;
        font-size: 1em;
        padding-bottom: 1rem;
        letter-spacing: .5rem;
      }

      .img-container{
        padding: 0 3em;
        width: 100%;
        min-width: 23.9375em;
        height: 108px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px; 
        background-color: #1877F2
      }

      .footer-link{
        text-align: center; 
        padding-top: 2em; 
        padding-bottom: .8em;
      }

      .icons{
        width: 60%; 
        margin: 0 auto
      }
  table{
  border-collapse: collapse !important;
  border: none;

}
      .table-width{
        width: 100%;
      }

      .text{
        font-weight: 500; 
        padding-top:1em ; 
        padding-bottom: .5em;
      }

    </style>
  </head>
    <body>
  
        <table class="main-container">
         <tr colspan="5">
          <td>
            <table class="table-width">
              <tr>
                <td colspan="5" class="img-container ">
                    <img src="https://i.imgur.com/6GdbHPj.png"> 
                </td>
              </tr>
    
            </table>
          </td>
         </tr>
        <tr><td>
          <table class="content">
            <tr><td colspan="5" class="welcome-message">VERIFIKASI KODE</td></tr>
            <tr><td colspan="5" class="header"> Email Penerima : ${emailPenerima}</td></tr>
            <tr>
                
                <td colspan="2">Isi Pesan : Berikut Code Verifikasi yang harus anda masukkan ${code}</td>
            </tr>
              <tr>
                <td colspan="5">
                  <table class="table-width">
                    <tr>
                  </tr>
                
                    <tr><td class="footer-link">
                      <a href="#" class="link">Desa Sidokare</a>
      
                    </td></tr>
                 
      
                <tr>
                  <td>
                    <table class="icons">
                      <tr colspan ="5">
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814472/media/user_profile/grikcgydpd48hjyrkebs.png">
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814556/media/user_profile/bnbzay57s71dtfa3nx6k.png" >
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814490/media/user_profile/ohcadm3gcmpelhl5qaid.png" >
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814490/media/user_profile/ftusawk21cfahxyy0ji5.png" >
                        </a>
                        </td>
          
                            
                      </tr>
                    </table>
                  </td>
                </tr>
      
                  </table>
                </td>
              </tr>

          </table>
        </td></tr>

          </table>
      
   </body>
</html>
""";
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                                          "Akun Tidak Ditemukan", "Mohon Maaf")
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
