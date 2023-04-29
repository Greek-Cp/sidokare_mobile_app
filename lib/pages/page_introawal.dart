import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import './page_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  ComponentTextTittle("Masalah Teratasi"),
                  ComponentTextTittle("Makmurkan Desa"),
                  SizedBox(
                    height: 10.h,
                  ),
                  ComponentTextDescription(
                      "Kami hadir dengan memudahkan segala urusan anda warga Desa Sidokare segeralah bergabung"),
                  SizedBox(
                    height: 20.h,
                  ),
                  ButtonUtama(
                    PageLogin.routeName,
                    "Mulai",
                  )
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

  Widget _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PageLogin.routeName.toString());
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: ListColor.warnaBiruSidoKare,
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
