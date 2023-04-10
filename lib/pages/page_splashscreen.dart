import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    await Future.delayed(Duration(milliseconds: 1500), () {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _iconLogin(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "D E S A  S I D O K A R E",
                        style: TextStyle(
                            fontSize: size.sizeHeader.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "Kecamatan Rejoso",
                        style: TextStyle(
                            fontSize: size.sizeDescriptionSedang.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
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
