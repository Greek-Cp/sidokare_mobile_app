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
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: 30,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: Container(
                                    color: Colors.amber,
                                    child: Text("$index"))),
                          ))),
                ),
                Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 30,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) => Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Card(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            "https://images.unsplash.com/photo-1679991811896-87ab6e0cd756?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                                            height: 200,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          Text(
                                            "Hati-hati!! BMD akan mengadakan lombaasdsadasdas,sadsadasdasdas",
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ))))
              ],
            ),
          ),
        );
      },
    );
  }
}
