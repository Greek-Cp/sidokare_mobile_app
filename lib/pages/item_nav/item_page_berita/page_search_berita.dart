import 'dart:convert';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/search_bar.dart';
import 'package:sidokare_mobile_app/const/const.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_detail_berita.dart';
import '../../../provider/provider_account.dart';

class PageSearchBerita extends StatefulWidget {
  static String? routeName = "/PageSearchBerita";

  @override
  State<PageSearchBerita> createState() => _PageSearchBeritaState();
}

class _PageSearchBeritaState extends State<PageSearchBerita> {
  late Future<List<Berita>> listBerita2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBerita2 = fetchBeritaKustomAll();
  }

  List<Berita> listDicari = [];
  List<Berita> hasilGetData = [];
  List<Berita> originalData = []; // Data asli dari API
  List<Berita> filteredData = []; // Data yang sudah difilter
  void filterData(String query) {
    if (query.isEmpty) {
      // Jika inputan kosong, tampilkan semua data asli
      setState(() {
        filteredData = originalData;
      });
    } else {
      // Jika inputan tidak kosong, filter data berdasarkan query
      setState(() {
        filteredData = originalData
            .where((item) => item.judulBerita
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        print("query = " + filteredData.length.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final id = ModalRoute.of(context)?.settings.arguments as String;
    //final id = 54;
    providerDiri = Provider.of<ProviderAccount>(context);
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == id.toInt());
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Cari Beritas",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: searchBar(),
              ),
              FutureBuilder<List<Berita>>(
                  future: listBerita2,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // menampilkan loading spinner
                    } else if (snapshot.hasError) {
                      return Text(
                          'Terjadi error: ${snapshot.error}'); // menampilkan pesan error
                    } else {
                      List<Berita> data =
                          snapshot.data!; // mengambil data dari snapshot
                      originalData =
                          data; // Ganti apiData dengan data yang didapatkan dari API
                      return AnimationLimiter(
                        child: ListView.builder(
                          itemCount: filteredData
                              .length, // menggunakan panjang data dari List<Berita> yang telah diambil dari snapshot
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = filteredData[index];
                            return AnimationConfiguration.staggeredList(
                                key: Key(index.toString()),
                                position: index,
                                duration: Duration(milliseconds: 1375),
                                child: SlideAnimation(
                                    horizontalOffset: 550.0,
                                    // delay: Duration(milliseconds: 400),
                                    duration: Duration(milliseconds: 800),
                                    child: FadeInAnimation(
                                        child: cardBeritaTerkini(
                                            berita: item,
                                            judul: item.judulBerita,
                                            gambar: item.unggahFileLain,
                                            foto: item.foto,
                                            tanggal: item.tanggalPublikasi,
                                            namaPengupload: item.namaUpload,
                                            fotoPengupload: item.foto_profile,
                                            isiBerita: item.isiBerita))));
                          }, // membangun widget cardBeritaTerkini dengan data yang ada di List<Berita>
                        ),
                      );
                    }
                  }),
            ]),
          ),
        );
      },
    );
  }

  TextEditingController textEditingController = TextEditingController();
  Widget searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          filterData(value);
        },
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: "Cari Berita",
            hintStyle: TextStyle(fontSize: 12.0),
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(Icons.search),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  late ProviderAccount providerDiri;
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

  Widget searchBaar() {
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
}
