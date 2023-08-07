import 'dart:async';
import 'dart:io';

import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/util_pref.dart';

import 'package:sidokare_mobile_app/pages/item_nav/page_laporan.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_status.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_utama.dart';
import 'package:sidokare_mobile_app/pages/page_formulirpengajuan.dart';

import '../component/Helper.dart';
import 'item_nav/page_berita.dart';

class HalamanUtama extends StatefulWidget {
  static String routeName = "/page_home ";

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _selectedIndex = 0;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity(BuildContext context) =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            btn4(context);
            setState(() => isAlertSet = true);
          }
        },
      );
  btn4(BuildContext context) {
    return Dialogs.bottomMaterialDialog(
      msg: 'Harap Periksa Ulang Koneksi / Internet',
      title: 'Tidak Ada Koneksi',
      color: Colors.white,
      lottieBuilder: Lottie.asset(
        "assets/koneks.json",
        fit: BoxFit.contain,
      ),
      context: context,
      enableDrag: false,
      isDismissible: false,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // Navigator.of(context).pop();
            if (Platform.isAndroid) {
              OpenSettings.openWIFISetting();
            }

            // OpenSettings.openDateSetting();
          },
          text: 'Pengaturan',
          iconData: Icons.wifi,
          textStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              btn4(context);
              setState(() => isAlertSet = true);
            }
          },
          text: 'Hubungkan',
          iconData: Icons.repeat,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  static List<int> arr = List.generate(100, (index) => index);

  static List<Widget> listPage = [
    PageUtama(),
    PageBerita(),
    PageLaporan(),
    PageStatus()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Konfirmasi'),
              content: Text('Yakin ingin keluar dari aplikasi?'),
              actions: [
                TextButton(
                  child: Text('tidak'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                  },
                ),
                TextButton(
                  child: Text('Iya'),
                  onPressed: () {
                    UtilPref()
                        .removeSingleAccount()
                        .then((value) => {print("Remove Success")});
                    UtilPref().saveLoginStatus(false);
                    UtilPref().saveSingleAccount(null);
                    SystemNavigator.pop(); // Keluar dari aplikasi
                  },
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
        body: Center(
          child: listPage.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          height: 50.h,
          animationCurve: Curves.easeInOut,
          buttonBackgroundColor: Colors.blueAccent,
          color: Colors.grey.shade100,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 25,
              color: _selectedIndex == 0 ? Colors.white : Colors.blueAccent,
              semanticLabel: "ngengek",
            ),
            Icon(
              Icons.newspaper,
              size: 25,
              color: _selectedIndex == 1 ? Colors.white : Colors.blueAccent,
            ),
            Icon(
              Icons.description,
              size: 25,
              color: _selectedIndex == 2 ? Colors.white : Colors.blueAccent,
              semanticLabel: "Inpokan",
            ),
            Icon(
              Icons.notifications,
              size: 25,
              color: _selectedIndex == 3 ? Colors.white : Colors.blueAccent,
              semanticLabel: "Inpokan",
            ),
          ],
          onTap: (index) {
            _onItemTapped(index);
            //Handle button tap
          },
        ),
      ),
    );
  }
}
