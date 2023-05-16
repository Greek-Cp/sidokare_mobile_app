import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';

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
    return WillPopScope(
      onWillPop: () async {
        // Tindakan yang ingin Anda lakukan ketika tombol kembali ditekan
        // Misalnya, menampilkan dialog konfirmasi sebelum keluar dari aplikasi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                    Navigator.of(context).pop(true); // Keluar dari aplikasi
                  },
                ),
              ],
            );
          },
        );

        // Menunda pop hingga dialog selesai
        return false;
      },
      child: Scaffold(
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
    // TODO: implement build
    // return Scaffold(
    //   body: Center(
    //     child: listPage.elementAt(_selectedIndex),
    //   ),
    //   // bottomNavigationBar: BottomNavigationBar(
    //   //     currentIndex: _selectedIndex,
    //   //     onTap: _onItemTapped,
    //   //     items: [
    //   //       BottomNavigationBarItem(
    //   //         label: " ",
    //   //         icon: Icon(Icons.home_filled),
    //   //       ),
    //   //       BottomNavigationBarItem(
    //   //           label: " ", icon: Icon(Icons.person_pin_circle))
    //   //     ]),
    //   bottomNavigationBar: CurvedNavigationBar(
    //     backgroundColor: Colors.white,
    //     height: 50.h,
    //     animationCurve: Curves.easeInOut,
    //     buttonBackgroundColor: Colors.blueAccent,
    //     color: Colors.grey.shade100,
    //     items: <Widget>[
    //       Icon(
    //         Icons.home,
    //         size: 25,
    //         color: _selectedIndex == 0 ? Colors.white : Colors.blueAccent,
    //         semanticLabel: "ngengek",
    //       ),
    //       Icon(
    //         Icons.newspaper,
    //         size: 25,
    //         color: _selectedIndex == 1 ? Colors.white : Colors.blueAccent,
    //       ),
    //       Icon(
    //         Icons.description,
    //         size: 25,
    //         color: _selectedIndex == 2 ? Colors.white : Colors.blueAccent,
    //         semanticLabel: "Inpokan",
    //       ),
    //       Icon(
    //         Icons.notifications,
    //         size: 25,
    //         color: _selectedIndex == 3 ? Colors.white : Colors.blueAccent,
    //         semanticLabel: "Inpokan",
    //       ),
    //     ],
    //     onTap: (index) {
    //       _onItemTapped(index);
    //       //Handle button tap
    //     },
    //   ),
    // );
  }
}
