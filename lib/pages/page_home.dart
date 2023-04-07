import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_detail_berita.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_laporan.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_status.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_utama.dart';
import 'package:sidokare_mobile_app/pages/page_formulirpengajuan.dart';

import 'item_nav/page_berita.dart';

class HalamanUtama extends StatefulWidget {
  static String routeName = "/page_home ";

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: listPage.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     onTap: _onItemTapped,
      //     items: [
      //       BottomNavigationBarItem(
      //         label: " ",
      //         icon: Icon(Icons.home_filled),
      //       ),
      //       BottomNavigationBarItem(
      //           label: " ", icon: Icon(Icons.person_pin_circle))
      //     ]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 60.h,
        animationCurve: Curves.easeInOut,
        color: Colors.blueAccent,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
            semanticLabel: "ngengek",
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Colors.white,
            semanticLabel: "Inpokan",
          ),
          Icon(
            Icons.bookmark_add,
            size: 30,
            color: Colors.white,
            semanticLabel: "Inpokan",
          ),
        ],
        onTap: (index) {
          _onItemTapped(index);
          //Handle button tap
        },
      ),
    );
  }
}
