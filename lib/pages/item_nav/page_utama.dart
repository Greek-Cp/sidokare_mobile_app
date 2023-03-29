import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:flutter_custom_tab_bar/models.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:flutter_custom_tab_bar/transform/tab_bar_transform.dart';

class PageUtama extends StatelessWidget {
  Widget searchBar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: TextField(
            style: TextStyle(fontSize: size.textButton.sp),
            decoration: InputDecoration(
                hintText: "Cari Berita Terkini",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.h)),
                prefixIcon: Icon(Icons.search))),
      ),
    );
  }

  Widget buttonKategoryBerita(String? namaButton) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ComponentTextButton("$namaButton"),
          Container(
            height: 10.h,
            width: 200,
            color: ListColor.warnaBiruSidoKare,
          )
        ],
      ),
    );
  }
  

  Widget _buildItem(BuildContext context, String title, Widget widget) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Headline',
                  style: TextStyle(fontSize: 18),
                ),
                _buildItem(context, "Linear Tab Bar", LinearIndicator()),

                /*
                SizedBox(
                  height: 200.0,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      buttonKategoryBerita("Pemerintahan Desa"),
                      buttonKategoryBerita("Pembangunan Desa"),
                      buttonKategoryBerita("aaa")
                    ],
                  ),
                ),
                */
                Text(
                  'Demo Headline 2',
                  style: TextStyle(fontSize: 18),
                ),
                Card(
                  child: ListTile(
                      title: Text('Motivation $int'),
                      subtitle:
                          Text('this is a description of the motivation')),
                ),
                Card(
                  child: ListTile(
                      title: Text('Motivation $int'),
                      subtitle:
                          Text('this is a description of the motivation')),
                ),
                Card(
                  child: ListTile(
                      title: Text('Motivation $int'),
                      subtitle:
                          Text('this is a description of the motivation')),
                ),
                Card(
                  child: ListTile(
                      title: Text('Motivation $int'),
                      subtitle:
                          Text('this is a description of the motivation')),
                ),
                Card(
                  child: ListTile(
                      title: Text('Motivation $int'),
                      subtitle:
                          Text('this is a description of the motivation')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
