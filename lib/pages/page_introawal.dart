import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import './page_login.dart';

class IntroAwal extends StatelessWidget {
  static String? routeName = "/introawal";
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _imageIntro(),
                  _textNganu(),
                  SizedBox(
                    height: 10.h,
                  ),
                  _textDesc(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _button(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imageIntro() {
    return Image.asset(
      "assets/intro1.png",
      width: 375.w,
      height: 363.h,
    );
  }

  Widget _textNganu() {
    return Column(
      children: <Widget>[
        Text(
          "Masalah Teratasi",
          style: TextStyle(
              fontSize: size.HeaderText.sp, fontWeight: FontWeight.bold),
        ),
        Text("Makmurkan Desa",
            style: TextStyle(
                fontSize: size.HeaderText.sp, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _textDesc() {
    return Text(
      "Kami hadir dengan memudahkan segala urusan anda warga Desa Sidokare segeralah bergabung",
      style: TextStyle(fontSize: size.DescTextKecil.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PageLogin.routeName.toString());
        },
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30.h),
            padding: EdgeInsets.symmetric(vertical: 18.h)),
        child: Text(
          "Mulai",
          style: TextStyle(fontSize: size.textButton),
        ),
      ),
    );
  }
}
