import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_detail_berita.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';
import 'package:sidokare_mobile_app/pages/page_berhasildaftar.dart';
import 'package:sidokare_mobile_app/pages/page_berhasilotp.dart';
import 'package:sidokare_mobile_app/pages/page_formulirAspirasi.dart';
import 'package:sidokare_mobile_app/pages/page_formulirKeluhan.dart';
import 'package:sidokare_mobile_app/pages/page_formulirpengajuan.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';
import 'package:sidokare_mobile_app/pages/page_inputotp.dart';
import 'package:sidokare_mobile_app/pages/page_introawal.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:sidokare_mobile_app/pages/page_lupasandi.dart';
import 'package:sidokare_mobile_app/pages/page_profileSettings.dart';
import 'package:sidokare_mobile_app/pages/page_register.dart';
import 'package:sidokare_mobile_app/pages/page_ubahsandi.dart';
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
        theme: ThemeData(fontFamily: fontfix.DmSansBruh),
        initialRoute: PageProfileUser.routeName.toString(),
        routes: {
          UbahSandi.routeName.toString(): (context) => UbahSandi(),
          berhasilOtp.routeName.toString(): (context) => berhasilOtp(),
          InputOtp.routeName.toString(): (context) => InputOtp(),
          LupaSandi.routeName.toString(): (context) => LupaSandi(),
          berhasildaftar.routeName.toString(): (context) => berhasildaftar(),
          SplashScreen.routeName.toString(): (context) => SplashScreen(),
          IntroAwal.routeName.toString(): (context) => IntroAwal(),
          PageLogin.routeName.toString(): (context) => PageLogin(),
          PageRegister.routeName.toString(): (context) => PageRegister(),
          HalamanUtama.routeName.toString(): (context) => HalamanUtama(),
          PageDetailBerita.routeName.toString(): (context) =>
              PageDetailBerita(),
          PageFormulirPengajuanPPID.routeName.toString(): (context) =>
              PageFormulirPengajuanPPID(),
          PageFormulirPengajuanKeluhan.routeName.toString(): (context) =>
              PageFormulirPengajuanKeluhan(),
          PageFormulirAspirasi.routeName.toString(): (context) =>
              PageFormulirAspirasi(),
          BerhasilBuatLaporan.routeName.toString(): (context) =>
              BerhasilBuatLaporan(),
          PageProfileUser.routeName.toString(): (context) => PageProfileUser()
        },
      ),
    );
  }
}
