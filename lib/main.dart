import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_search_berita.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_detail_berita.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_utama.dart';
import 'package:sidokare_mobile_app/pages/item_page_detailPengajuan/page_DetailAspirasi.dart';
import 'package:sidokare_mobile_app/pages/item_page_detailPengajuan/page_DetailKeluhan.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';
import 'package:sidokare_mobile_app/pages/item_page_detailPengajuan/page_DetailPengajuanPPID.dart';
import 'package:sidokare_mobile_app/pages/page_berhasildaftar.dart';
import 'package:sidokare_mobile_app/pages/page_berhasilotp.dart';
import 'package:sidokare_mobile_app/pages/page_detail_aspirasi.dart';
import 'package:sidokare_mobile_app/pages/page_detail_keluhan.dart';
import 'package:sidokare_mobile_app/pages/page_detail_status.dart';
import 'package:sidokare_mobile_app/pages/page_formulirAspirasi.dart';
import 'package:sidokare_mobile_app/pages/page_formulirKeberatan.dart';
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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();

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
        initialRoute: SplashScreen.routeName,
        builder: EasyLoading.init(),
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
          PageProfileUser.routeName.toString(): (context) => PageProfileUser(),
          PageSearchBerita.routeName.toString(): (context) =>
              PageSearchBerita(),
          PageDetailStatus.routeName.toString(): (context) =>
              PageDetailStatus(),
          PageDetailKeluhan.routeName.toString(): (context) =>
              PageDetailKeluhan(),
          PageDetailAspirasi.routeName.toString(): (context) =>
              PageDetailAspirasi(),
          PageFormulirKeberatanPPID.routeName.toString(): (context) =>
              PageFormulirKeberatanPPID(),
          DetailPengajuanPPID.routeName.toString(): (context) =>
              DetailPengajuanPPID(),
          PageDetailAspirasiiii.routeName.toString(): (context) =>
              PageDetailAspirasiiii(),
          PageDetailKeluhann.routeName.toString(): (context) =>
              PageDetailKeluhann(),
        },
      ),
    );
  }
}
