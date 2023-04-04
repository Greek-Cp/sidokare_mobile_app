import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class berhasilOtp extends StatelessWidget {
  static String? routeName = "/SuccesOtp";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(builder: (context, child) {
      return Scaffold(
          body: Container(
        child: Center(
          child: Padding(
            padding: size.paddingHorizontalAwalFrame,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _gambarSukses(),
                  SizedBox(
                    height: 20.h,
                  ),
                  ComponentTextTittle("Berhasil Verifikasi"),
                  ComponentTextDescription(
                      "Kode yang telah dimasukkan berhasil silahkan login ke akunmu"),
                  SizedBox(
                    height: 20.h,
                  ),
                  ButtonUtama(PageLogin.routeName, "Lanjut")
                ]),
          ),
        ),
      ));
    });
  }

  Widget _gambarSukses() {
    return Image.asset(
      "assets/sukses.png",
      width: 200.w,
      height: 200.h,
    );
  }

  Widget _headerForm() {
    return Text(
      "Berhasil Verifikasi",
      style:
          TextStyle(fontSize: size.sizeHeader.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return Text(
      "Kode yang telah dimasukkan berhasil silahkan login ke akunmu",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: size.SubHeader.sp),
    );
  }

  Widget _buttonLanjut() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Lanjut"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30.h),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
