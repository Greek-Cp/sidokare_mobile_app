import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash_screen";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                children: const <Widget>[
                  Text(
                    "D E S A  S I D O K A R E",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Kecamatan Rejoso",
                    style: TextStyle(
                        fontSize: 16,
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
  }

  Widget _iconLogin() {
    return Image.asset(
      "assets/nganjuk.png",
      width: 80,
      height: 80,
    );
  }
}
