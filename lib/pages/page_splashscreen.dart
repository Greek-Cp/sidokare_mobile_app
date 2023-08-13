import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/const/util_pref.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:wave_transition/wave_transition.dart';
import './page_introawal.dart';

class SplashScreen extends StatefulWidget {
  static String? routeName = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late Future<ModelAccount> futureMdl;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UtilPref().getLoginStatus().then((value) => {
          if (value)
            {_nextUtama()}
          else
            {
              UtilPref().getSaveFirstTime().then((value) => {
                    if (value) {_getLogin()} else {_nextbro()}
                  })
            }
        });
    /*

    UtilPref().getSingleAccount().then((value) => {
          if (value == null) {_nextbro()} else {}
        });
    */
  }

  _nextUtama() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          WaveTransition(
              child: HalamanUtama(),
              center: FractionalOffset(0.90, 0.90),
              duration: Duration(milliseconds: 1000) // optional
              ));
    });
  }

  _getLogin() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          WaveTransition(
              child: PageLogin(),
              center: FractionalOffset(0.90, 0.90),
              duration: Duration(milliseconds: 1000) // optional
              ));
    });
  }

  _nextbro() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      await Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(
            context,
            WaveTransition(
                child: IntroAwal(),
                center: FractionalOffset(0.90, 0.90),
                duration: Duration(milliseconds: 1000) // optional
                ));
      });
    } else if (status.isPermanentlyDenied) {
      // Pengguna telah secara permanen menolak akses lokasi, Anda bisa memberikan pesan untuk meminta pengguna mengaktifkan izin di pengaturan perangkat

      await Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.push(
            context,
            WaveTransition(
                child: IntroAwal(),
                center: FractionalOffset(0.90, 0.90),
                duration: Duration(milliseconds: 1000) // optional
                ));
        ToastWidget.ToastWarning(
            context,
            "Mohon Izinkan agar aplikasi berjalan lancar , Dapat melalui Pengaturan pada Aplikasi ",
            "Perizinan");
      });
    } else {
      // Pengguna menolak izin akses lokasi

      await Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.push(
            context,
            WaveTransition(
                child: IntroAwal(),
                center: FractionalOffset(0.90, 0.90),
                duration: Duration(milliseconds: 1000) // optional
                ));
      });
      ToastWidget.ToastWarning(
          context,
          "Mohon Izinkan agar aplikasi berjalan lancar , Dapat melalui Pengaturan pada Aplikasi ",
          "Perizinan");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Container(
            color: ListColor.warnaBiruSidoKare,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimationConfiguration.synchronized(
                      child: FadeInAnimation(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 500),
                    child: ScaleAnimation(
                      delay: Duration(milliseconds: 500),
                      duration: Duration(milliseconds: 500),
                      child: _iconLogin(),
                    ),
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimationConfiguration.synchronized(
                          child: FadeInAnimation(
                        duration: Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          horizontalOffset: 500,
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "D E S A  S I D O K A R E",
                            style: GoogleFonts.dmSans(
                                fontSize: size.sizeHeader.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )),
                      AnimationConfiguration.synchronized(
                          child: FadeInAnimation(
                        duration: Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          horizontalOffset: -500,
                          delay: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Kecamatan Rejoso",
                            style: GoogleFonts.dmSans(
                                fontSize: size.sizeDescriptionSedang.sp,
                                color: Colors.white),
                          ),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _iconLogin() {
    return Image.asset(
      "assets/nganjuk.png",
      width: 80.w,
      height: 80.h,
    );
  }
}
