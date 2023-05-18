import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
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
import 'package:sidokare_mobile_app/const/util_pref.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:http/http.dart' as http;
import 'package:sidokare_mobile_app/model/response/get/response_jumlahLaporan.dart';
import 'package:sidokare_mobile_app/pages/item_nav/item_page_berita/page_search_berita.dart';
import 'package:sidokare_mobile_app/pages/page_formulirAspirasi.dart';
import 'package:sidokare_mobile_app/pages/page_formulirKeberatan.dart';
import 'package:sidokare_mobile_app/pages/page_formulirKeluhan.dart';
import 'package:sidokare_mobile_app/pages/page_profileSettings.dart';
import '../../const/const.dart';
import '../../provider/provider_account.dart';
import '../page_formulirpengajuan.dart';
import 'page_detail_berita.dart';
import 'package:intl/intl.dart';

class PageUtama extends StatefulWidget {
  @override
  State<PageUtama> createState() => _PageUtamaState();
}

class _PageUtamaState extends State<PageUtama> {
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;
  String? waktu = "";
  Map<String, dynamic> dataLaporan = {};

  late Future<List<Berita>> listBerita;
  late Future<List<Berita>> listBerita2;
  late ModelAccount modelFroumPRef;
  late Future<ModelAccount> futureModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    JumlahLaporan.getDataLaporan().then((value) {
      setState(() {
        dataLaporan = value;
      });
    });
    UtilPref().getSingleAccount().then((value) => modelFroumPRef = value);
    listBerita = fetchBeritaKustom("ktg_berita01");
    listBerita2 = fetchBeritaKustom2();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    futureModel = UtilPref().getSingleAccount();
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Pagi';
    }
    if (hour < 17) {
      return 'Siang';
    }
    return 'Malam';
  }

  Widget searchBar({String? idakun}) {
    return Container(
      height: 64.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Container(
          child: TextField(
              onTap: () {
                print("object");
                Navigator.pushNamed(
                    context, PageSearchBerita.routeName.toString(),
                    arguments: idakun);
              },
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

  String namaFormat(String nameFull) {
    String NamaFull = nameFull;
    print("Nama Full ${NamaFull}");
    String convertBruh = NamaFull.split(" ")[0];
    print("hasil Convert : ${convertBruh}");
    return convertBruh;
  }

  List<String> listPengajuan = ["PPID", "Keluhan", "Aspirasi", "Status"];
  late ProviderAccount providerDiri;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    providerDiri = Provider.of<ProviderAccount>(context);

    // Gunakan objek singleAccount dalam UI
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
            body: SafeArea(
          maintainBottomViewPadding: true,
          child: FutureBuilder<ModelAccount>(
            future: futureModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ModelAccount DataDiri = modelFroumPRef;
                print("data diri = " + DataDiri.id_akun.toString());
                List<ModelAccount> listAcc = [DataDiri];
                providerDiri.setDataDiri(listAcc);
                int id = DataDiri.id_akun!.toInt();
                providerDiri.setIdAkun(id);
                return SingleChildScrollView(
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
                                      "Selamat ${greeting()} ${namaFormat(DataDiri!.nama.toString())}"),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        providerDiri.setIdAkun(
                                            DataDiri.id_akun!.toInt());
                                        Navigator.pushNamed(
                                            context,
                                            PageProfileUser.routeName
                                                .toString(),
                                            arguments: {
                                              "id": id,
                                              "url_gbr":
                                                  DataDiri.urlGambar.toString()
                                            });
                                      },
                                      child: Container(
                                        width: 40.w,
                                        child: CircleAvatar(
                                          backgroundImage: DataDiri.urlGambar
                                                          .toString() ==
                                                      "" ||
                                                  DataDiri.urlGambar
                                                          .toString() ==
                                                      null ||
                                                  DataDiri.urlGambar == "kosong"
                                              ? AssetImage(
                                                      "assets/accountBlank.png")
                                                  as ImageProvider
                                              : NetworkImage(
                                                  "http://${ApiPoint.BASE_URL}/storage/profile/${DataDiri.urlGambar?.replaceAll("'", "")}",
                                                  headers: {
                                                      "Connection": "Keep-Alive"
                                                    }) as ImageProvider,
                                        ),
                                      ),
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
                          child: FadeInAnimation(
                              child: GestureDetector(
                                  child: searchBar(
                                      idakun: DataDiri.id_akun.toString()))),
                        ),
                      )),
                      // searchBar(),
                      SizedBox(
                        height: 10.h,
                      ),

                      // searchBar(),

                      AnimationLimiter(
                          child: AnimationConfiguration.synchronized(
                        duration: Duration(milliseconds: 500 * 2),
                        child: ScaleAnimation(
                          child: FadeInAnimation(child: CardJumlahLaporan()),
                        ),
                      )),
                      // CardJumlahLaporan(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 10.h),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimationLimiter(
                                child: AnimationConfiguration.synchronized(
                              duration: Duration(milliseconds: 375),
                              child: SlideAnimation(
                                horizontalOffset: -50.0,
                                child: FadeInAnimation(
                                    child: ComponentTextTittle("Pengajuan")),
                              ),
                            )),
                          ],
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: SizedBox(
                            height: 80.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // scrollDirection: Axis.horizontal,
                              children: [
                                AnimationLimiter(
                                    child: AnimationConfiguration.synchronized(
                                  duration: Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    horizontalOffset: -50.0,
                                    child: FadeInAnimation(
                                        child: buttonPengajuan(
                                            "PPID",
                                            Icons.assignment,
                                            id,
                                            PageFormulirPengajuanPPID.routeName
                                                .toString())),
                                  ),
                                )),
                                AnimationLimiter(
                                    child: AnimationConfiguration.synchronized(
                                  duration: Duration(milliseconds: 375 * 2),
                                  child: SlideAnimation(
                                    horizontalOffset: -50.0,
                                    child: FadeInAnimation(
                                        child: buttonPengajuan(
                                            "Keluhan",
                                            Icons.analytics,
                                            id,
                                            PageFormulirPengajuanKeluhan
                                                .routeName
                                                .toString())),
                                  ),
                                )),
                                AnimationLimiter(
                                    child: AnimationConfiguration.synchronized(
                                  duration: Duration(milliseconds: 375 * 3),
                                  child: SlideAnimation(
                                    horizontalOffset: -50.0,
                                    child: FadeInAnimation(
                                        child: buttonPengajuan(
                                            "Aspirasi",
                                            Icons.library_books_rounded,
                                            id,
                                            PageFormulirAspirasi.routeName
                                                .toString())),
                                  ),
                                )),

                                // AnimationLimiter(
                                //     child: AnimationConfiguration.synchronized(
                                //   duration: Duration(milliseconds: 375 * 4),
                                //   child: SlideAnimation(
                                //     horizontalOffset: -50.0,
                                //     child: FadeInAnimation(
                                //         child: buttonPengajuan("Status", "a")),
                                //   ),
                                // )),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 10.h),
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
                                          "Berita Terkini")),
                                ),
                              )),
                              // AnimationLimiter(
                              //     child: AnimationConfiguration.synchronized(
                              //   duration: Duration(milliseconds: 375),
                              //   child: SlideAnimation(
                              //     horizontalOffset: 50.0,
                              //     child: FadeInAnimation(
                              //         child: ComponentTextDescription(
                              //       "Lihat lainnya",
                              //       teksColor: ListColor.warnaDescriptionItem,
                              //     )),
                              //   ),
                              // )),
                            ],
                          )),
                      SizedBox(
                          height: 300.h,
                          child: FutureBuilder<List<Berita>>(
                              future: listBerita2,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(); // menampilkan loading spinner
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'Terjadi error: ${snapshot.error}'); // menampilkan pesan error
                                } else {
                                  List<Berita> data = snapshot
                                      .data!; // mengambil data dari snapshot
                                  print("tess ${data.length}");
                                  if (data.length != 0) {
                                    return AnimationLimiter(
                                      child: ListView.builder(
                                        itemCount: data
                                            .length, // menggunakan panjang data dari List<Berita> yang telah diambil dari snapshot
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 1375),
                                                  child: SlideAnimation(
                                                      horizontalOffset: 550.0,
                                                      // delay: Duration(milliseconds: 400),
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      child: FadeInAnimation(
                                                          child: cardBeritaTerkini(
                                                              berita:
                                                                  data[index],
                                                              judul: data[index]
                                                                  .judulBerita,
                                                              gambar: data[index]
                                                                  .unggahFileLain,
                                                              foto: data[index]
                                                                  .foto,
                                                              tanggal: data[
                                                                      index]
                                                                  .tanggalPublikasi,
                                                              namaPengupload:
                                                                  data[index]
                                                                      .namaUpload,
                                                              fotoPengupload:
                                                                  data[index]
                                                                      .foto_profile,
                                                              isiBerita: data[
                                                                      index]
                                                                  .isiBerita))));
                                        }, // membangun widget cardBeritaTerkini dengan data yang ada di List<Berita>
                                      ),
                                    );
                                  }
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Lottie.asset(
                                            "assets/newspaper.json",
                                            fit: BoxFit.cover),
                                      ),
                                      Text(
                                        "Belum ada berita baru / terkini",
                                        style: TextStyle(
                                            fontSize: 14.0.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Tunggu berita baru akan dibuat admin",
                                        style: TextStyle(fontSize: 11.0.sp),
                                      ),
                                    ],
                                  ));
                                }
                              })),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
      },
    );
  }

  Widget buttonPengajuan(String text, IconData data, int id, String Route) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.h)),
            color: ListColor.warnaBiruSidoKare,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Route, arguments: id);
              },
              child: Padding(
                padding: EdgeInsets.all(10.0.h),
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  child: Icon(
                    data,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ComponentTextDescription("${text}")
        ],
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ItemCardLaporan(
                          iconnya: Icons.all_inbox,
                          namaLaporan: "Jumlah Laporan",
                          Jumlah: "${dataLaporan['TotalLaporan']}"),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: ItemCardLaporan(
                            iconnya: Icons.assignment,
                            namaLaporan: "Laporan PPID",
                            Jumlah: "${dataLaporan['JumlahPPID']}"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                    width: 25.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ItemCardLaporan(
                          iconnya: Icons.analytics,
                          Jumlah: "${dataLaporan['JumlahAspirasi']}",
                          namaLaporan: "Laporan Aspirasi"),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: ItemCardLaporan(
                            iconnya: Icons.library_books_rounded,
                            Jumlah: "${dataLaporan['JumlahKeluhan']}",
                            namaLaporan: "Laporan Keluhan"),
                      ),
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

  Widget ItemCardLaporan(
      {String? Jumlah, String? namaLaporan, IconData? iconnya}) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              iconnya,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ComponentTextTittle(
              Jumlah,
              textAlign: TextAlign.start,
              warnaTeks: Colors.white,
            ),
            ComponentTextDescription(
              namaLaporan,
              textAlign: TextAlign.start,
              teksColor: Colors.white,
            )
          ],
        )
      ],
    );
  }

  Widget cardBeritaTerkini(
      {Berita? berita,
      String? judul,
      String? isiBerita,
      String? foto,
      String? tanggal,
      String? gambar,
      String? namaPengupload,
      String? fotoPengupload}) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse("${berita?.tanggalPublikasi}");
    String HasilFormatTgl = DateFormat('EEEE, dd-MM-yyyy').format(tempDate);
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
              onTap: () => {
                providerDiri.setBerita(berita),
                Navigator.of(context)
                    .pushNamed(PageDetailBerita.routeName, arguments: {
                  "judul": judul,
                  "isi_berita": isiBerita,
                  "gambar_utama": foto,
                  "tanggal_publikasi": tanggal,
                  "gambar_lain": gambar,
                  "nama_pengupload": namaPengupload,
                  "profile_pengupload": fotoPengupload
                })
              },
              highlightColor: Colors.blue.withOpacity(0.4),
              splashColor: ListColor.warnaBiruSidoKare.withOpacity(0.5),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "${berita?.foto}",
                      fit: BoxFit.cover,
                      height: 140.h,
                      width: double.infinity.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Text("${berita?.judulBerita}",
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
                        "${berita?.isiBerita}",
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
                              backgroundImage: berita?.foto_profile == "" ||
                                      berita?.foto_profile == null
                                  ? AssetImage("assets/accountBlank.png")
                                      as ImageProvider
                                  : NetworkImage(
                                          "http://${ApiPoint.BASE_URL}/storage/profile/${berita?.foto_profile!.replaceAll("'", "")}")
                                      as ImageProvider,
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
                                  "${berita?.namaUpload}",
                                  style: TextStyle(fontSize: size.SubHeader.sp),
                                ),
                                Text(
                                  HasilFormatTgl,
                                  style: TextStyle(
                                      color: ListColor.warnaDescriptionItem,
                                      fontSize: size.SubHeader.sp - 3),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            ),
                          ),
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
