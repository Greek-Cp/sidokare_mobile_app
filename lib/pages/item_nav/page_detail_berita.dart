import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';

import '../../const/const.dart';

class PageDetailBerita extends StatefulWidget {
  static String routeName = "/detail_berita";

  @override
  State<PageDetailBerita> createState() => _PageDetailBeritaState();
}

class _PageDetailBeritaState extends State<PageDetailBerita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController getNama = TextEditingController();
  Map? receiveData;
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    receiveData = ModalRoute.of(context)?.settings.arguments as Map;
    String judul_berita = receiveData?['judul'];
    String isi_berita = receiveData?['isi_berita'];
    String gambar_utama = receiveData?['gambar_utama'];
    String fotoProfile = receiveData?['profile_pengupload'];
    String namaProfile = receiveData?['nama_pengupload'];
    //convert

    String tanggal_publikasi = receiveData?['tanggal_publikasi'];
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(tanggal_publikasi);
    String HasilFormatTgl = DateFormat('yyyy-MM-dd').format(tempDate);
    String gambar_lain = receiveData?['gambar_lain'];
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double opacity = 0.0;
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => {Navigator.pop(context)},
                ),
                elevation: 10,
                shadowColor: ListColor.warnaBiruSidoKare,
                snap: false,
                floating: true,
                stretch: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: ListColor.warnaBiruSidoKare,
                pinned: true,
                expandedHeight: 180.w,
                flexibleSpace: FlexibleSpaceBar(
                  title: AnimationConfiguration.synchronized(
                    duration: Duration(milliseconds: 800),
                    child: SlideAnimation(
                      verticalOffset: 200,
                      child: Text(
                        "${judul_berita}",
                        style: TextStyle(
                          fontSize: size.DescTextKecil.sp,
                        ),
                      ),
                    ),
                  ),
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 50.0.h, bottom: 20.0.h),
                  collapseMode: CollapseMode.parallax,
                  background: AnimationConfiguration.synchronized(
                      child: ScaleAnimation(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          scale: 2.0,
                          child: _Image(gambar_utama))),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  AnimationConfiguration.synchronized(
                      duration: Duration(milliseconds: 800),
                      child: SlideAnimation(
                          verticalOffset: -200,
                          child: _HeaderJudul(judul_berita))),
                  _ListMbu(
                    kategoriBerita: "Pemerintah Desa",
                  ),
                  _ListBerita(
                      tanggalBerita: HasilFormatTgl.toString(),
                      profilePic: fotoProfile.toString(),
                      authBerita: "${namaProfile.toString()}"),
                  _isiBerita(isiBerita: isi_berita),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: AnimationConfiguration.synchronized(
                      child: FadeInAnimation(
                        duration: Duration(milliseconds: 700),
                        child: SlideAnimation(
                          verticalOffset: 500,
                          duration: Duration(milliseconds: 700),
                          child: Divider(
                            thickness: 2,
                            height: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimationConfiguration.synchronized(
                      child: ScaleAnimation(
                          duration: Duration(milliseconds: 700),
                          child: _CommentItemUser())),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: AnimationConfiguration.synchronized(
                      child: FadeInAnimation(
                        duration: Duration(milliseconds: 700),
                        child: SlideAnimation(
                          verticalOffset: 500,
                          duration: Duration(milliseconds: 700),
                          child: Divider(
                            thickness: 2,
                            height: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimationConfiguration.synchronized(
                      child: ScaleAnimation(
                    duration: Duration(milliseconds: 700),
                    child: _isiKomen(),
                  ))
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _CommentItemUser() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Komentar Berita",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.HeaderText.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircleAvatar(backgroundColor: Colors.red),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    "Deva Arie",
                    style: TextStyle(
                        fontSize: size.SubHeader.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.menu_sharp)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Jika Anda menjadi panitia dan masih bingung ingin mengadakan apa, simak 20 ide lomba 17 Agustus yang seru dan menarik berikut ini.",
              style: TextStyle(fontSize: size.sizeDescriptionPas.sp),
            )
          ]),
    );
  }

  Widget _Image(String urlImage) {
    return Image.network(
      urlImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200.h,
    );
  }

  Widget _HeaderJudul(String judul) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Text(
        judul,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size.HeaderText.sp),
      ),
    );
  }

  Widget _ListBerita(
      {String? tanggalBerita, String? authBerita, String? profilePic}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimationConfiguration.synchronized(
              duration: Duration(milliseconds: 700),
              child: SlideAnimation(
                horizontalOffset: -500,
                child: Text(
                  "Tanggal Publikasi : ${tanggalBerita}",
                  style: TextStyle(fontSize: size.DescTextKecil.sp),
                ),
              )),
          AnimationConfiguration.synchronized(
              duration: Duration(milliseconds: 700),
              child: SlideAnimation(
                  horizontalOffset: 500,
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                              "http://${ApiPoint.BASE_URL}/storage/profile/${profilePic}")),
                      Text("${authBerita}",
                          style: TextStyle(fontSize: size.DescTextKecil.sp))
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget _ListMbu({String? kategoriBerita}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimationConfiguration.synchronized(
            duration: Duration(milliseconds: 700),
            child: SlideAnimation(
              horizontalOffset: -500,
              child: Card(
                color: Color.fromARGB(255, 236, 241, 255),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                  child: Text(
                    "${kategoriBerita}",
                    style: TextStyle(fontSize: size.textButton.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _isiBerita({String? isiBerita}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: AnimationConfiguration.synchronized(
        child: FadeInAnimation(
          child: SlideAnimation(
            verticalOffset: 500,
            duration: Duration(milliseconds: 1000),
            child: Text(
              "${isiBerita}",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: size.sizeDescriptionPas.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _isiKomen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Aktifitas Lainnya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.SubHeader.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: textFieldResponsive(hint: "Nama", radiusCorner: 10),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child:
                      textFieldMultiLineResponsive(hint: "Masukkan Komentar")),
              ButtonForm("Kirim Komentar", _formKey, KirimPesan()),
            ],
          )),
    );
  }

  Widget textFieldResponsive(
      {String? hint, double radiusCorner = 10, TextInputControl? controller}) {
    return TextFormField(
        style: TextStyle(fontSize: size.textButton.sp),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: 15.0.w, bottom: 1.0.h, top: 1.0.h, right: 5.0.w),
          hintText: "$hint",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusCorner.h)),
        ));
  }

  Widget textFieldMultiLineResponsive(
      {String? hint, double radiusCorner = 10, TextInputControl? controller}) {
    return TextFormField(
        style: TextStyle(fontSize: size.textButton.sp),
        minLines: 3,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "$hint",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusCorner.h)),
        ));
  }

  KirimPesan() {}
}
