import 'package:flutter/material.dart';

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

  static const List<Widget> listPage = [
    Text("Hello"),
    Text("Hello"),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: listPage.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(onTap: _onItemTapped, items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.abc),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.abc_outlined))
      ]),
    );
  }
}
