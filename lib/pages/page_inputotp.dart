import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
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
                  const SizedBox(
                    height: 20,
                  ),
                  _inputOtp(),
                  _ButtonVerif()
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
