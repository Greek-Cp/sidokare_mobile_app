import 'dart:async';
import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentar.dart';
import 'package:sidokare_mobile_app/model/response/modelkomentarlist.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../component/image_class.dart';
import '../../const/const.dart';

class PageDetailBerita extends StatefulWidget {
  static String routeName = "/detail_berita";

  @override
  State<PageDetailBerita> createState() => _PageDetailBeritaState();
}

enum itemEdit { Edit, Hapus }

class _PageDetailBeritaState extends State<PageDetailBerita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController getNama = TextEditingController();
  TextEditingController? getKomen = TextEditingController();
  TextEditingController? komenBaru = TextEditingController();

  Map? receiveData;
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  getConnectivity(BuildContext context) =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            btn4(context);
            setState(() => isAlertSet = true);
          }
        },
      );

  btn4(BuildContext context) {
    return Dialogs.bottomMaterialDialog(
      msg: 'Harap Periksa Ulang Koneksi / Internet',
      title: 'Tidak Ada Koneksi',
      color: Colors.white,
      lottieBuilder: Lottie.asset(
        "assets/koneks.json",
        fit: BoxFit.contain,
      ),
      context: context,
      enableDrag: false,
      isDismissible: false,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // Navigator.of(context).pop();
            if (Platform.isAndroid) {
              OpenSettings.openWIFISetting();
            }

            // OpenSettings.openDateSetting();
          },
          text: 'Pengaturan',
          iconData: Icons.wifi,
          textStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              btn4(context);
              setState(() => isAlertSet = true);
            }
          },
          text: 'Hubungkan',
          iconData: Icons.repeat,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  List<DataBerita>? BeritaList = [];
  late Future<bool> removeKomentar;
  late Future<ModelKomentarList> future;
  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  late String idAkun;
  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    receiveData = ModalRoute.of(context)?.settings.arguments as Map;
    // String p = receiveData?['judul'];
    // print("Kontol Hitam :: ${p}");
    final provider = Provider.of<ProviderAccount>(context);
    Berita berita = provider.getBerita;

    String judul_berita = berita.judulBerita.toString();
    String isi_berita = berita.isiBerita.toString();
    String gambar_utama = berita.foto.toString();
    // String fotoProfile = berita.foto_profile.toString();
    String namaProfile = berita.namaUpload.toString();
    String idBerita = berita.idBerita.toString();
    String namaKategori = berita.namaKategoriBerita.toString();
    print("Nama Kategori == ${namaKategori}");
    print(idBerita.toString());
    future = ControllerAPI.getKomentar(idBerita);
    idAkun = provider.id_akun.toString();

    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == idAkun.toInt());

    String tanggal_publikasi = berita.tanggalPublikasi.toString();
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(tanggal_publikasi);
    String HasilFormatTgl = DateFormat('dd MMM, yyyy').format(tempDate);
    String gambar_lain = berita.unggahFileLain.toString();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    late List<Berita> listBerita;
    double opacity = 0.0;
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: CustomScrollView(
            // reverse: true,
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
                    borderRadius: BorderRadius.circular(0)),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
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
                        for (var berita in BeritaList!) {
                          print("Judul Utama: ${berita.isiKomentar}");
                          print("Isi Utama: ${berita.idKomentar}");
                          print(
                              "============="); // Membuat baris kosong antara berita
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: BeritaList!.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.synchronized(
                              child: FadeInAnimation(
                                duration: Duration(milliseconds: 700),
                                child: ScaleAnimation(
                                  duration: Duration(milliseconds: 700),
                                  child: _CommentItemUser(
                                      snapshot.data!.data![index],
                                      index,
                                      komenBaru!),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
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
                        getCurrentDateTime().toString(),
                        namaProfile.toString(),
                        DataDiri.urlGambar.toString()),
                  )),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _CommentItemUser(
      DataBerita data, int index, TextEditingController Kontroller) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 10.0.h),
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
                  child: BunderImageProfile(
                    namaGambar: data.profilePicKomen.toString(),
                    lebarFoto: 20,
                    tinggiFoto: 20,
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
                int.parse(idAkun) == data.idAkun.toInt()
                    ? PopupMenuButton(
                        itemBuilder: (context) => <PopupMenuEntry<itemEdit>>[
                              PopupMenuItem(
                                  onTap: () {
                                    removeKomentar =
                                        ControllerAPI.hapusKomentarById(
                                            id_akun: data.idAkun,
                                            id_berita: data.idBerita.toString(),
                                            id_komentar: data.idKomentar,
                                            waktu_berkomentar:
                                                data.waktuBerkomentar);
                                    setState(() {
                                      BeritaList!.remove(index);
                                    });
                                    FutureBuilder<bool>(
                                      future: removeKomentar,
                                      builder: (context, snapshot) {
                                        print("Snapshot = " +
                                            snapshot.data.toString());
                                        if (snapshot.data == true) {
                                          return Text("Hapus Berhasil");
                                        } else {
                                          return Text("c");
                                        }
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("Hapus")
                                    ],
                                  )),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text("Edit")
                                  ],
                                ),
                                onTap: () {
                                  Future.delayed(
                                    const Duration(seconds: 0),
                                    () => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Ganti Komentar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            content: TextField(
                                              controller: Kontroller,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Masukkan Komentar"),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              onChanged: (value) {
                                                // Kontroller.text = value;
                                              },
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          minimumSize:
                                                              Size.fromHeight(
                                                                  44)),
                                                  onPressed: () {
                                                    ControllerAPI.editKomentar(
                                                        idKomentar:
                                                            data.idKomentar,
                                                        isiKomentar:
                                                            Kontroller.text);
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Text("Tetapkan"))
                                            ],
                                          );
                                        }),
                                  );
                                },
                              )
                            ])
                    : Container()
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              data.isiKomentar.toString(),
              style: TextStyle(fontSize: size.sizeDescriptionPas.sp),
            ),
          ]),
    );
  }

  Widget _Image(String urlImage) {
    // return Image.network(
    //   "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${urlImage}",
    //   fit: BoxFit.cover,
    //   width: double.infinity,
    //   height: 200.h,
    // );
    return CachedNetworkImage(
        imageUrl:
            "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${urlImage}",
        height: 200.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Shimmer.fromColors(
              child: Container(
                width: double.infinity,
                height: 140.h,
                color: Colors.white,
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100);
        },
        progressIndicatorBuilder: (context, url, progress) =>
            Shimmer.fromColors(
                child: Container(
                  width: double.infinity,
                  height: 140.h,
                  color: Colors.white,
                ),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100));
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
      {String? tanggalBerita, String? authBerita, String? namaKategori}) {
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
                    backgroundImage:
                        AssetImage("assets/accountBlank.png") as ImageProvider,
                  ),
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
      String id_akun, id_berita, isi_komentar, waktuBerkomentar, nama, gbr) {
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
                          idAkun: id_akun,
                          idBerita: id_berita.toString(),
                          isiKomentar: getKomen!.text,
                          waktuBerkomentar: waktuBerkomentar,
                          namaPengkomen: nama,
                          profilePicKomen: gbr));
                    });

                    Future<ModelKomentar> d = ControllerAPI.buatKomentar(
                        id_akun, id_berita, getKomen!.text, waktuBerkomentar);
                    getKomen!.clear();
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
