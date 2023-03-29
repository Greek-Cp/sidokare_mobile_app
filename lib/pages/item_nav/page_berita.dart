import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:sidokare_mobile_app/component/search_bar.dart';

class PageBerita extends StatefulWidget {
  @override
  State<PageBerita> createState() => _PageBeritaState();
}

class _PageBeritaState extends State<PageBerita> {
  final int pageCount = 5;
  final PageController _controller = PageController();
  CustomTabBarController _tabBarController = CustomTabBarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SearchBar(),
            CustomTabBar(
              tabBarController: _tabBarController,
              height: 40,
              itemCount: listKategoriBerita.length,
              builder: getTabbarChild,
              indicator: LinearIndicator(color: Colors.blueAccent, bottom: 1),
              pageController: _controller,
            ),
            Expanded(
                child: PageView(
              controller: _controller,
              //Dibawha tempat untuk menaruh card ya ges yak
              // children: [PageSatu(), PageDua()],
            ))
          ],
        ),
      ),
    );
  }

  var listKategoriBerita = [
    "Pembayaran Desa",
    "Pelayanan Desa ",
    "Pembuatan Surat Desa",
    "inpo Janda Desa"
  ];
  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
      index: pageCount,
      transform: ColorsTransform(
          highlightColor: Colors.black,
          normalColor: Colors.black,
          builder: (context, color) {
            return Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              constraints: BoxConstraints(minWidth: 60),
              child: (Text(
                listKategoriBerita[index],
                style: TextStyle(fontSize: 14, color: color),
              )),
            );
          }),
    );
  }
}
