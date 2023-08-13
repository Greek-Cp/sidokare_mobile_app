import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';
import '../../../component/shimmer_loading.dart';
import '../../../const/const.dart';
import '../../../const/list_color.dart';
import '../page_detail_berita.dart';
import 'package:intl/intl.dart' as intl;

class PagePembinaanMasyarakat extends StatefulWidget {
  @override
  State<PagePembinaanMasyarakat> createState() =>
      _PagePembinaanMasyarakatState();
}

class _PagePembinaanMasyarakatState extends State<PagePembinaanMasyarakat> {
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
    final provider = Provider.of<ProviderAccount>(context);

    listBerita = fetchBeritaKustom("ktg_berita07");
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FutureBuilder<List<Berita>>(
              future: listBerita,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // menampilkan loading spinner
                } else if (snapshot.hasError) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      LoadingShimmerBerita(
                        LebarContainer: 350,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LoadingShimmerBerita(
                        LebarContainer: 350,
                      ),
                    ],
                  ); // menampilkan pesan error
                } else {
                  List<Berita> data =
                      snapshot.data!; // mengambil data dari snapshot
                  if (data.length != 0) {
                    //Ada berita
                    return AnimationLimiter(
                      child: ListView.builder(
                        itemCount: data
                            .length, // menggunakan panjang data dari List<Berita> yang telah diambil dari snapshot
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              provider.setBerita(data[index]);

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
                                  });
                            },
                            child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: index % 2 == 0
                                    ? FadeInAnimation(
                                        duration: Duration(milliseconds: 300),
                                        child: SlideAnimation(
                                            duration:
                                                Duration(milliseconds: 800),
                                            horizontalOffset: 350.0,
                                            child: _cardInformasi(data[index])),
                                      )
                                    : FadeInAnimation(
                                        duration: Duration(milliseconds: 300),
                                        child: SlideAnimation(
                                            duration:
                                                Duration(milliseconds: 800),
                                            horizontalOffset: -350.0,
                                            child: _cardInformasi(data[index])),
                                      )),
                          );
                        }, // membangun widget cardBeritaTerkini dengan data yang ada di List<Berita>
                      ),
                    );
                  } else {
                    //Kosong
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Lottie.asset("assets/newspaper.json",
                              fit: BoxFit.cover),
                        ),
                        Text(
                          "Belum Ada Berita Pembeniaan Masyarakat",
                          style: TextStyle(
                              fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Tunggu berita akan dibuat admin",
                          style: TextStyle(fontSize: 11.0.sp),
                        ),
                      ],
                    ));
                  }
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
                  badgePosition: BadgePosition.bottomStart,
                  textDirection: TextDirection.rtl,
                  badgeCornerRadius: Radius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _ImagesBruh(berita.foto.toString()),
                    _TextDesc(berita.isiBerita, berita.judulBerita),
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
      "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${urlGambar.toString()}",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
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
          ],
        ),
      ),
    );
  }

  Widget _TextDesc(String? textDesc, String? textHeader) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
