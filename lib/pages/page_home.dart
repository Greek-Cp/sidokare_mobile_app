import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_utama.dart';

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

  static List<Widget> listPage = [PageBerita(), PageUtama()];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: listPage.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              label: " ",
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
                label: " ", icon: Icon(Icons.person_pin_circle))
          ]),
    );
  }
}
