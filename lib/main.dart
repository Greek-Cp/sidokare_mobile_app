import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/pages/page_berhasildaftar.dart';
import 'package:sidokare_mobile_app/pages/page_introawal.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:sidokare_mobile_app/pages/page_lupasandi.dart';
import 'package:sidokare_mobile_app/pages/page_register.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';
import './pages/page_splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderAccount(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: LupaSandi.routeName.toString(),
        routes: {
          LupaSandi.routeName.toString(): (context) => LupaSandi(),
          berhasildaftar.routeName.toString(): (context) => berhasildaftar(),
          SplashScreen.routeName.toString(): (context) => SplashScreen(),
          IntroAwal.routeName.toString(): (context) => IntroAwal(),
          PageLogin.routeName.toString(): (context) => PageLogin(),
          PageRegister.routeName.toString(): (context) => PageRegister()
        },
      ),
    );
  }
}
