import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class berhasilOtp extends StatelessWidget {
  static String? routeName = "/SuccesOtp";
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _gambarSukses(),
                    SizedBox(
                      height: 20.h,
                    ),
                    _headerForm(),
                    _descSukses(),
                    SizedBox(
                      height: 20.h,
                    ),
                    _buttonLanjut()
                  ]),
            ),
          ),
        ));
      },
    );
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
          TextStyle(fontSize: size.HeaderText.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _descSukses() {
    return Text(
      "Kode yang telah dimasukkan berhasil silahkan login ke akunmu",
      style: TextStyle(fontSize: size.DescTextKecil.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _buttonLanjut() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Lanjut",
          style: TextStyle(fontSize: size.textButton.sp),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(30.h),
            padding: EdgeInsets.symmetric(vertical: 15.h)),
      ),
    );
  }
}
