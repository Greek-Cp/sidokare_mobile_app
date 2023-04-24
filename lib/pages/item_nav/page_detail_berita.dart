import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentar.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentarlist.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../const/const.dart';

class PageDetailBerita extends StatefulWidget {
  static String routeName = "/detail_berita";

  @override
  State<PageDetailBerita> createState() => _PageDetailBeritaState();
}

class _PageDetailBeritaState extends State<PageDetailBerita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController getNama = TextEditingController();
  TextEditingController? getKomen = TextEditingController();

  Map? receiveData;
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;

  List<DataBerita>? BeritaList = [];

  late Future<ModelKomentarList> future;
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
    final provider = Provider.of<ProviderAccount>(context);
    Berita berita = provider.getBerita;

    String judul_berita = berita.judulBerita.toString();
    String isi_berita = berita.isiBerita.toString();
    String gambar_utama = berita.foto.toString();
    String fotoProfile = berita.foto_profile.toString();
    String namaProfile = berita.namaUpload.toString();
    String idBerita = berita.idBerita.toString();
    String namaKategori = berita.namaKategoriBerita.toString();
    print("Nama Kategori == ${namaKategori}");
    print(idBerita.toString());
    future = ControllerAPI.getKomentar(idBerita);
    String idAkun = provider.id_akun.toString();

    String tanggal_publikasi = berita.tanggalPublikasi.toString();
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(tanggal_publikasi);
    String HasilFormatTgl = DateFormat('dd MMM, yyyy').format(tempDate);
    String gambar_lain = berita.unggahFileLain.toString();
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
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    Navigator.pop(context);
                  },
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
                  _ListBerita(
                      tanggalBerita: HasilFormatTgl.toString(),
                      profilePic: fotoProfile.toString(),
                      namaKategori: namaKategori,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: AnimationConfiguration.synchronized(
                      child: FadeInAnimation(
                        duration: Duration(milliseconds: 700),
                        child: ScaleAnimation(
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            "Komentar Berita",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.HeaderText.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<ModelKomentarList>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        BeritaList = snapshot.data!.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: BeritaList!.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.synchronized(
                              child: FadeInAnimation(
                                duration: Duration(milliseconds: 700),
                                child: ScaleAnimation(
                                  duration: Duration(milliseconds: 700),
                                  child: _CommentItemUser(
                                      snapshot.data!.data![index]),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
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
                    child: _isiKomen(
                        idAkun,
                        idBerita,
                        getKomen?.text.toString(),
                        "2023-04-11 11:28:12",
                        namaProfile.toString(),
                        fotoProfile.toString()),
                  ))
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _CommentItemUser(DataBerita data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(
                        "http://${ApiPoint.BASE_URL}/storage/profile/${data.profilePicKomen.toString()}"),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    data.namaPengkomen.toString(),
                    style: TextStyle(
                        fontSize: size.SubHeader.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.more_vert_outlined)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              data.isiKomentar.toString(),
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
      {String? tanggalBerita,
      String? authBerita,
      String? profilePic,
      String? namaKategori}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.h),
        child: AnimationConfiguration.synchronized(
          child: ScaleAnimation(
            duration: Duration(milliseconds: 700),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "http://${ApiPoint.BASE_URL}/storage/profile/${profilePic}")),
                  title: Text("${authBerita}"),
                  subtitle: Text("${tanggalBerita}"),
                  trailing: Card(
                    color: Color.fromARGB(255, 236, 241, 255),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                      child: Text(
                        "${namaKategori}",
                        style: TextStyle(fontSize: size.DescTextKecil.sp),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(),
                )
              ],
            ),
          ),
        ));
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

  Widget _isiKomen(
      String id_akun, id_berita, isi_komentar, waktuBerkomentar, nama, profil) {
    print("Isi Komentar");
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
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: textFieldMultiLineResponsive(
                      hint: "Masukkan Komentar", controllerText: getKomen)),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      BeritaList!.add(DataBerita(
                          idAkun: id_akun.toInt(),
                          idBerita: id_berita.toString().toInt(),
                          isiKomentar: getKomen!.text,
                          waktuBerkomentar: waktuBerkomentar,
                          namaPengkomen: nama,
                          profilePicKomen: profil));
                    });

                    Future<ModelKomentar> d = ControllerAPI.buatKomentar(
                        id_akun, id_berita, getKomen!.text, waktuBerkomentar);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(45.h)),
                  child: Text("Kirim Komentar"))
            ],
          )),
    );
  }

  Widget textFieldResponsive(
      {String? hint,
      double radiusCorner = 10,
      TextInputControl? controller,
      TextEditingController? controllerText}) {
    return TextFormField(
        controller: controllerText,
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
      {String? hint,
      double radiusCorner = 10,
      TextEditingController? controllerText}) {
    return TextFormField(
        controller: controllerText,
        style: TextStyle(fontSize: size.textButton.sp),
        minLines: 3,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "$hint",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusCorner.h)),
        ));
  }
}
