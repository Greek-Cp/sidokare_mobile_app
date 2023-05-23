import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/util.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/page_berhasilotp.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:sidokare_mobile_app/pages/page_ubahsandi.dart';
import '../const/fontfix.dart';
import '../const/size.dart';

class InputOtp extends StatefulWidget {
  static String? routeName = "/input_otp";
  @override
  State<InputOtp> createState() => _InputOtpState();
}

class _InputOtpState extends State<InputOtp> {
  static String? codeVerif;
  String? otp;
  static String? pilihPage;
  static String? emailTerbawah;
  Map? receiveData;
  int _countdown = 30;
  Timer? _timer;
  bool statusHitungMundur = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countdown < 1) {
          statusHitungMundur = false;
          _timer?.cancel();
        } else {
          _countdown = _countdown - 1;
        }
      });
    });
  }

  void resendOTP(String email) {
    if (_countdown == 0) {
      setState(() {
        _countdown = 30;
        statusHitungMundur = true;

        sendMail(email);
      });

      startCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    receiveData = ModalRoute.of(context)?.settings.arguments as Map;
    String? otp = receiveData?['otp'];
    emailTerbawah = receiveData?['email'];
    pilihPage = receiveData?['code_page'];
    return ScreenUtilInit(
      builder: (context, child) {
        print(otp.toString() + "OTP");
        return Scaffold(
          body: Container(
            child: Padding(
              padding: size.paddingHorizontalAwalFrame,
              child: ListView(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () => {}, icon: Icon(Icons.arrow_back)),
                      ]),
                  _HeaderText(),
                  _DescHeaderText(),
                  _ImageLupaKataSandi(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _inputOtp(),
                  _ButtonVerif(),
                  SizedBox(height: 5.h),
                  statusHitungMundur == true
                      ? Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Kirim Ulang OTP Dalam Waktu ",
                                  style: TextStyle(
                                    fontFamily: fontfix.DmSansBruh,
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: "${formatTime(_countdown)}",
                                  style: TextStyle(
                                    fontFamily: fontfix.DmSansBruh,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: Colors.blue,
                                  ),
                                )
                              ])))
                      : Center(
                          child: GestureDetector(
                            onTap: () {
                              resendOTP(emailTerbawah.toString());
                            },
                            child: Text(
                              'Kirim Ulang Kode Verifikasi',
                              style: TextStyle(
                                fontFamily: fontfix.DmSansBruh,
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _HeaderText() {
    return const Text(
      "Kode OTP",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: 28),
      textAlign: TextAlign.center,
    );
  }

  Widget _DescHeaderText() {
    return Text(
      "Silakan Masukkan Kode OTP",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh, fontSize: size.HeaderText.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _ImageLupaKataSandi() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Image.asset(
          "assets/imageotp.png",
          width: 260.w,
          height: 256.h,
        ),
      ),
    );
  }

  sendMail(String input_email) {
    String username = 'e41211358@student.polije.ac.id';
    String password = 'ojmqzqkblieamunx';

    var rng = new Random();
    var code = rng.nextInt(90000) + 10000;
    print("kode nya adalah = ${code}");
    final smtpServer = gmail(username, password);
    String emailPenerima = input_email;
    print(emailPenerima + " Get");
    final message = Message()
      ..from = Address(username, 'Reuni321 TEAM')
      ..recipients.add(emailPenerima)
      ..subject = 'Verifikasi Kode Lupa Sandi'
      ..html = "<h1>Kode Verifikasi</h1>\n<h3>Kode Verifikasi == ${code} </h3>";

    // print('Message sent: ' + sendReport.toString());
    try {
      final sendReport = send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        // ToastWidget.ToastEror(context, ' Format Email Tidak Sesuai');
      }
    }
  }

  Widget _inputOtp() {
    return OtpTextField(
      numberOfFields: 5,
      fieldWidth: 50.w,
      focusedBorderColor: ListColor.warnaBiruSidoKare,
      enabledBorderColor: ListColor.warnaBiruSidoKare,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      borderWidth: 1.0.w,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
        width: 4.0,
      ))),
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here
        print("kode dimasukkan == " + code);
      },
      //runs when every textfield is filled
      onSubmit: (String verificationCode) {
        print("verif Kode == " + verificationCode);
        codeVerif = verificationCode;
      }, // end onSubmit
    );
  }

  Widget _ButtonVerif() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          print(codeVerif.toString() + ":" + otp.toString());
          print("Tes Page ${pilihPage}");
          if (codeVerif.toString() == receiveData?['otp'].toString()) {
            if (pilihPage == "toSuccesRegister") {
              HttpStatefull.verifikasiAkun(receiveData?['email'])
                  .then((value) => {
                        if (value.code == 200)
                          {
                            Navigator.popAndPushNamed(
                                context, berhasilOtp.routeName.toString()),
                          }
                      });
            } else if (pilihPage == "toLupaSandi") {
              Navigator.pushNamed(context, UbahSandi.routeName.toString(),
                  arguments: emailTerbawah);
            }
          } else {
            ToastWidget.ToastEror(
                context, "Kode Otp Salah", "Periksa dan Teliti Kembali Lagi");
            // codeVerif == "";
          }
        },
        // ignore: sort_child_properties_last
        child: Text(
          "Konfirmasi",
          style: TextStyle(
              fontFamily: fontfix.DmSansBruh, fontSize: size.textButton.sp),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
      ),
    );
  }
}
