import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';

import '../component/jenis_button.dart';
import '../component/text_description.dart';

class BerhasilBuatLaporan extends StatefulWidget {
  static String routeName = "/BerhasilBuatLaporan";
  @override
  State<BerhasilBuatLaporan> createState() => _BerhasilBuatLaporanState();
}

class _BerhasilBuatLaporanState extends State<BerhasilBuatLaporan> {
  @override
  Widget build(BuildContext context) {
    final idAkunnn = ModalRoute.of(context)?.settings.arguments as String;
    var myIntAkunn = int.parse(idAkunnn);
    assert(myIntAkunn is int);
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
                      height: 5.h,
                    ),
                    ComponentTextTittle("Laporan Berhasil Diajukan"),
                    ComponentTextDescription(
                        "Tunggu secara berkala pengajuanmu hingga segera teratasi"),
                    SizedBox(
                      height: 20.h,
                    ),
                    _Button(
                        context, HalamanUtama.routeName, "Selesai", myIntAkunn)
                  ]),
            ),
          ),
        ));
      },
    );
  }

  Widget _gambarSukses() {
    return Lottie.asset(
      "assets/report_done.json",
      width: 200.w,
      height: 200.h,
    );
  }

  Widget _Button(BuildContext context, String? routeName, String? buttonName,
      int idAkunn) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName.toString(),
              arguments: idAkunn);
        },
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
      ),
    );
  }
}
