import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sidokare_mobile_app/component/search_bar.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_bum_desa.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pelayanan_desa.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pembangunan_desa.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pemberdayaan_masyarakat.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pembinaan_masyarakat.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pemerintahan_desa.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_pkk_desa.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_potensi_desa.dart';

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
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                AnimationLimiter(
                    child: AnimationConfiguration.synchronized(
                        duration: const Duration(milliseconds: 500),
                        child: FadeInAnimation(
                            child: ScaleAnimation(child: searchBar())))),
                AnimationLimiter(
                    child: AnimationConfiguration.synchronized(
                        duration: const Duration(milliseconds: 500),
                        child: FadeInAnimation(
                            child: SlideAnimation(
                          verticalOffset: 50,
                          child: CustomTabBar(
                            tabBarController: _tabBarController,
                            height: 40.h,
                            itemCount: listKategoriBerita.length,
                            builder: getTabbarChild,
                            indicator: LinearIndicator(
                                color: Colors.blueAccent, bottom: 1),
                            pageController: _controller,
                          ),
                        )))),
                Expanded(
                    child: PageView(
                  controller: _controller,
                  //Dibawha tempat untuk menaruh card ya ges yak
                  children: [
                    PagePemerintahanDesa(),
                    PagePembangunanDesa(),
                    PagePemberdayaanMasyarakat(),
                    PagePembinaanMasyarakat(),
                    PageBumDesa(),
                    PagePKK(),
                    PagePotensiDesa()
                  ],
                )),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchBar() {
    return Container(
      height: 64.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Container(
          child: TextField(
              style: TextStyle(fontSize: size.textButton.sp),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 5.0.w, bottom: 1.0.h, top: 1.0.h, right: 5.0.w),
                  hintText: "Cari Berita Terkini",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.h)),
                  prefixIcon: Icon(Icons.search))),
        ),
      ),
    );
  }

  var listKategoriBerita = [
    "Pemerintahan Desa",
    "Pembagunan Desa",
    "Pemberdayaan Masyarakat",
    "Pembinaan Masyarakat",
    "BUM Desa",
    "PKK",
    "Potensi Desa"
  ];
  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
      index: pageCount,
      transform: ColorsTransform(
          highlightColor: Colors.black,
          normalColor: Colors.black,
          builder: (context, color) {
            return Container(
              padding: EdgeInsets.all(5.h),
              alignment: Alignment.center,
              constraints: BoxConstraints(minWidth: 60.w),
              child: (Text(
                listKategoriBerita[index],
                style: TextStyle(fontSize: 14.sp, color: color),
              )),
            );
          }),
    );
  }
}
