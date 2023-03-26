import 'package:flutter/material.dart';
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
                  ComponentTextTittle("Masalah Teratasi Makmurkan Desa"),
                  const SizedBox(
                    height: 10,
                  ),
                  ComponentTextDescription(
                      "Kami hadir dengan memudahkan segala urusan anda warga Desa Sidokare segeralah bergabung"),
                  const SizedBox(
                    height: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PageLogin.routeName.toString());
        },
        child: Text("Mulai"),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(30),
            padding: const EdgeInsets.symmetric(vertical: 18)),
      ),
    );
  }
}
