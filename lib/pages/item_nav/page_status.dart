import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_status/page_list_status.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_status/page_list_status_aspirasi.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_status/page_list_status_keluhan.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

import 'item_page_berita/page_pelayanan_desa.dart';
import 'item_page_berita/page_pemberdayaan_masyarakat.dart';
import 'item_page_berita/page_pemerintahan_desa.dart';

class PageStatus extends StatefulWidget {
  @override
  State<PageStatus> createState() => _PageStatusState();
}

class _PageStatusState extends State<PageStatus>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: myTabs.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: "PPID",
    ),
    Tab(
      text: "Keluhan",
    ),
    Tab(
      text: "Aspirasi",
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final providerAccount = Provider.of<ProviderAccount>(context);
    print("Id akunnya adalah berapa ? = ${providerAccount.getIdAkun}");
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  ComponentTextTittle("Status Pengajuan Surat"),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: DefaultTabController(
                  length: myTabs.length,
                  child: TabBar(
                      controller: tabController,
                      labelColor: ListColor.warnaBiruSidoKare,
                      unselectedLabelColor: Colors.grey,
                      tabs: myTabs),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TabBarView(controller: tabController, children: [
                itemListStatus(providerAccount.getIdAkun, "PPID"),
                itemListStatusKeluhan(providerAccount.getIdAkun, "KELUHAN"),
                itemListStatusAspirasi(providerAccount.getIdAkun, "ASPIRASI"),
              ]),
            ));
      },
    );
  }
}
