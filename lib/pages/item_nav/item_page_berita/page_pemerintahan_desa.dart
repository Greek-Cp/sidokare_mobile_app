import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_detail_berita.dart';
import '../../../const/list_color.dart';

class PagePemerintahanDesa extends StatefulWidget {
  @override
  State<PagePemerintahanDesa> createState() => _PagePemerintahanDesaState();
}

class _PagePemerintahanDesaState extends State<PagePemerintahanDesa> {
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;
  late Future<List<Berita>> listBerita;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    listBerita = fetchBeritaKustom("ktg_berita03");
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FutureBuilder<List<Berita>>(
              future: listBerita,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PageDetailBerita.routeName,
                                arguments: {
                                  "judul": data[index].judulBerita,
                                  "isi_berita": data[index].isiBerita,
                                  "gambar_utama": data[index].foto,
                                  "tanggal_publikasi":
                                      data[index].tanggalPublikasi,
                                  "gambar_lain": data[index].unggahFileLain,
                                  "nama_pengupload": data[index].namaUpload,
                                  "profile_pengupload": data[index].foto_profile
                                });
                          },
                          child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: FadeInAnimation(

                                  // delay: Duration(milliseconds: 400),
                                  duration: Duration(milliseconds: 800),
                                  child: FadeInAnimation(
                                      child: index % 2 == 0
                                          ? FadeInAnimation(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: SlideAnimation(
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  horizontalOffset: 350.0,
                                                  child: _cardInformasi(
                                                      data[index])),
                                            )
                                          : FadeInAnimation(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: SlideAnimation(
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  horizontalOffset: -350.0,
                                                  child: _cardInformasi(
                                                      data[index])),
                                            )))),
                        );
                      }, // membangun widget cardBeritaTerkini dengan data yang ada di List<Berita>
                    ),
                  );
                }
              })),
    );
  }

  Widget _cardInformasi(Berita berita) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, offset: Offset(0.0, 1.0), //(x,y)
                  )
                ]),
            child: Container(
              foregroundDecoration: RotatedCornerDecoration.withColor(
                  color: ListColor.warnaBiruSidoKare,
                  badgeSize: Size(50.w, 50.h),
                  textDirection: TextDirection.rtl,
                  badgePosition: BadgePosition.bottomStart,
                  badgeCornerRadius: Radius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _ImagesBruh(berita.foto.toString()),
                    _TextDesc(berita.judulBerita, berita.isiBerita),
                    _KetBawah(berita.tanggalPublikasi.toString())
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget _ImagesBruh(String? urlGambar) {
    return Image.network(
      "${urlGambar.toString()}",
      fit: BoxFit.contain,
    );
  }

  Widget _KetBawah(String? tanggalBawah) {
    DateTime tempDate =
        new intl.DateFormat("yyyy-MM-dd hh:mm:ss").parse("${tanggalBawah}");
    String HasilFormatTgl =
        intl.DateFormat('EEEE, dd MMMM yyyy').format(tempDate);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: () {},
              icon: Icon(Icons.date_range),
              padding: EdgeInsets.all(0),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HasilFormatTgl,
                  style: TextStyle(
                      color: ListColor.warnaDescriptionItem,
                      fontSize: size.SubHeader.sp - 3),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10)),
            //   elevation: 0,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(),
            //     child: Container(
            //       width: 30.w,
            //       height: 30.h,
            //       child: IconButton(
            //         iconSize: 20,
            //         onPressed: () {},
            //         icon: Icon(Icons.send),
            //         alignment: Alignment.topRight,
            //         padding: EdgeInsets.all(0),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _TextDesc(String? textDesc, String? textHeader) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${textHeader}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.SubHeader),
          ),
        ),
        Text(
          "${textDesc}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: size.sizeDescriptionPas),
        )
      ],
    );
  }
}
