import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:wave_transition/wave_transition.dart';
import './page_introawal.dart';

class SplashScreen extends StatefulWidget {
  static String? routeName = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextbro();
  }

  _nextbro() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.push(
          context,
          WaveTransition(
              child: IntroAwal(),
              center: FractionalOffset(0.90, 0.90),
              duration: Duration(milliseconds: 1000) // optional
              ));
    });
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
