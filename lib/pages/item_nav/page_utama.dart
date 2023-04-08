import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
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
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:http/http.dart' as http;
import '../../provider/provider_account.dart';

class PageUtama extends StatefulWidget {
  @override
  State<PageUtama> createState() => _PageUtamaState();
}

class _PageUtamaState extends State<PageUtama> {
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;

  late Future<List<Berita>> listBerita;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBerita = fetchBerita();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
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

  Widget buttonKategoryBerita(String? namaButton) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ComponentTextButton("$namaButton"),
          Container(
            height: 0.h,
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final id = ModalRoute.of(context)?.settings.arguments as int;

    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == id);
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: -50.0,
                          child: FadeInAnimation(
                            child: ComponentTextTittle(
                                "Selamat Pagi ${DataDiri.nama}"),
                          ),
                        ),
                      )),
                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              width: 41.w,
                              height: 41.h,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                AnimationLimiter(
                    child: AnimationConfiguration.synchronized(
                  duration: Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: searchBar()),
                  ),
                )),
                // searchBar(),
                SizedBox(
                  height: 10.h,
                ),
                AnimationLimiter(
                    child: AnimationConfiguration.synchronized(
                  duration: Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    child: FadeInAnimation(child: CardJumlahLaporan()),
                  ),
                )),
                // CardJumlahLaporan(),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: -50.0,
                          child: FadeInAnimation(
                              child: ComponentTextTittle("Berita Terkini")),
                        ),
                      )),
                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                        duration: Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                              child: ComponentTextDescription(
                            "Lihat lainnya",
                            teksColor: ListColor.warnaDescriptionItem,
                          )),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                    height: 300.h,
                    child: FutureBuilder<List<Berita>>(
                        future: listBerita,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(); // menampilkan loading spinner
                          } else if (snapshot.hasError) {
                            return Text(
                                'Terjadi error: ${snapshot.error}'); // menampilkan pesan error
                          } else {
                            List<Berita> data =
                                snapshot.data!; // mengambil data dari snapshot

                            return AnimationLimiter(
                              child: ListView.builder(
                                itemCount: data
                                    .length, // menggunakan panjang data dari List<Berita> yang telah diambil dari snapshot
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          // delay: Duration(milliseconds: 400),
                                          duration: Duration(milliseconds: 800),
                                          child: FadeInAnimation(
                                              child: cardBeritaTerkini(
                                                  data[index]))));
                                }, // membangun widget cardBeritaTerkini dengan data yang ada di List<Berita>
                              ),
                            );
                          }
                        })),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CardJumlahLaporan() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(),
      child: Card(
        child: InkWell(
          onTap: () => {},
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.white.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  ListColor.GradientwarnaBiruSidoKare,
                  ListColor.warnaBiruSidoKare
                ])),
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemCardLaporan(),
                      ItemCardLaporan(),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemCardLaporan(),
                      ItemCardLaporan(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ItemCardLaporan() {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          child: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComponentTextTittle(
              "774,098",
              textAlign: TextAlign.start,
              warnaTeks: Colors.white,
            ),
            ComponentTextDescription(
              "Jumlah Laporan",
              textAlign: TextAlign.start,
              teksColor: Colors.white,
            )
          ],
        )
      ],
    );
  }

  Widget cardBeritaTerkini(Berita berita) {
    return SizedBox(
      width: 300.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            color: Colors.white,
            child: InkWell(
              onTap: () => {},
              highlightColor: Colors.blue.withOpacity(0.4),
              splashColor: ListColor.warnaBiruSidoKare.withOpacity(0.5),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "${berita.foto}",
                      fit: BoxFit.cover,
                      height: 140.h,
                      width: double.infinity.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Text("${berita.judulBerita}",
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.sizeDescriptionSedang.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Text(
                        "${berita.isiBerita}",
                        style: TextStyle(
                            color: ListColor.warnaDescriptionItem,
                            fontSize: size.SubHeader.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sang Dong-Min",
                                  style: TextStyle(fontSize: size.SubHeader.sp),
                                ),
                                Text(
                                  "${berita.tanggalPublikasi}",
                                  style: TextStyle(
                                      color: ListColor.warnaDescriptionItem,
                                      fontSize: size.SubHeader.sp - 3),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: ListColor.warnaBackgroundIcon,
                            child: Padding(
                              padding: EdgeInsets.all(3.0.h),
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                child: Icon(
                                  Icons.wysiwyg,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
