import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sidokare_mobile_app/component/Helper.dart';
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

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
    _timer?.cancel();
  }

  getConnectivity(BuildContext context) =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            btn4(context);
            setState(() => isAlertSet = true);
          }
        },
      );

  btn4(BuildContext context) {
    return Dialogs.bottomMaterialDialog(
      msg: 'Harap Periksa Ulang Koneksi / Internet',
      title: 'Tidak Ada Koneksi',
      color: Colors.white,
      lottieBuilder: Lottie.asset(
        "assets/koneks.json",
        fit: BoxFit.contain,
      ),
      context: context,
      enableDrag: false,
      isDismissible: false,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // Navigator.of(context).pop();
            if (Platform.isAndroid) {
              OpenSettings.openWIFISetting();
            }

            // OpenSettings.openDateSetting();
          },
          text: 'Pengaturan',
          iconData: Icons.wifi,
          textStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              btn4(context);
              setState(() => isAlertSet = true);
            }
          },
          text: 'Hubungkan',
          iconData: Icons.repeat,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
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

  void resendOTP(String email, String kodee) {
    if (_countdown == 0) {
      setState(() {
        _countdown = 30;
        statusHitungMundur = true;

        sendMail(email, kodee);
      });

      startCountdown();
    }
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
                              resendOTP(
                                  emailTerbawah.toString(), otp.toString());
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

  sendMail(String input_email, String otpne) async {
    String username = 'e41211358@student.polije.ac.id';
    String password = 'ltddukvjccanwukp';

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
      ..html = """ <!DOCTYPE html>
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
            <tr><td colspan="5" class="header"> Email Penerima : ${input_email}</td></tr>
            <tr>
                
                <td colspan="2">Isi Pesan : Berikut Code Verifikasi yang harus anda masukkan ${otpne}</td>
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
</html>""";

    // print('Message sent: ' + sendReport.toString());
    try {
      final sendReport = await send(message, smtpServer);
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
