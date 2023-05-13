import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/font_type.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/pages/page_formulirKeberatan.dart';

import '../../const/const.dart';
import '../../model/response/get/controller_get.dart';
import '../../provider/provider_account.dart';

class DetailPengajuanPPID extends StatefulWidget {
  static String? routeName = "/DetailPengajuanPPID";

  @override
  State<DetailPengajuanPPID> createState() => _DetailPengajuanPPIDState();
}

class _DetailPengajuanPPIDState extends State<DetailPengajuanPPID> {
  Map? getData;
  @override
  Widget build(BuildContext context) {
    getData = ModalRoute.of(context)?.settings.arguments as Map;
    int Akunn = getData?['id_akun'];
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == Akunn.toInt());
    String isiLaporan = getData?['isiLaporan'];
    String id_ppid = getData?['id_ppid'];
    String judullaporan = getData?['judulLaporan'];
    String asalPelapor = getData?['AsalPelapor'];
    String KategoriPPID = getData?['kategoriPPID'];
    String RT = getData?['RT'];
    String RW = getData?['RW'];
    String status = getData?['status'];
    String DocPPID = getData?['dokumenUp'];
    String? filePendukung = getData?['uploadFile'];
    DateTime currentTime = DateTime.now();
    String timeStamp = currentTime.toString();

    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [],
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: ComponentTextTittle("Detail Pengajuan PPID"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription("Nama Lengkap"),
                            ComponentTextDescription("NIK"),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ": ${DataDiri.nama}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.sizeDescriptionPas.sp),
                            ),
                            // ComponentTextDescription(": ${DataDiri.nama}"),
                            ComponentTextDescription(": ${DataDiri.Nik}"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ComponentTextDescription("Judul Laporan"),
                    ComponentTittleCustom(
                      "${judullaporan}",
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ComponentTextDescription("Isi Laporan"),
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: Container(
                          width: double.infinity,
                          child: ComponentTextDescription(
                            "${isiLaporan}",
                            teksColor: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription("Asal Pelapor"),
                            ComponentTextDescription("RT / RW"),
                            ComponentTextDescription("Kategori PPID"),
                            ComponentTextDescription("Upload File Pendukung"),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription(": ${asalPelapor} "),
                            ComponentTextDescription(": ${RT} / ${RW}"),
                            ComponentTextDescription(": ${KategoriPPID}"),
                            Text(filePendukung.toString().length > 20
                                ? ": " +
                                    filePendukung.toString().substring(0, 20) +
                                    '...'
                                : ": ${filePendukung}"),
                            // ComponentTextDescription(": ${filePendukung}"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey,
                    ),
                    ComponentTextDescription("Hasil PPID: "),
                    GestureDetector(
                      onTap: () async {
                        print("halooo");
                        if (DocPPID.toString() != "kosong") {
                          String url =
                              'http://${ApiPoint.BASE_URL}/storage/dummyOutput/${DocPPID.toString()}'; // Ganti dengan URL file yang ingin Anda unduh
                          // String savedDir =
                          //     '/storage/emulated/0/Download/${timeStamp}-${DocPPID.toString()}';
                          DateTime currentTime = DateTime.now();
                          DateFormat formatter = DateFormat('yyyyMMddHHmmss');
                          String timestamp = formatter.format(currentTime);
                          var getDownload = await getDownloadsDirectory();
                          String path =
                              "${getDownload}\\${timestamp}_${DocPPID.toString()}";
                          String replaceBruh = path.replaceAll("'", "");
                          replaceBruh =
                              replaceBruh.replaceAll("Directory: ", "");
                          print(replaceBruh);
                          String savedDir =
                              "C:\\Users\\LENOVO\\Downloads\\Named123_ppid677.pdf";
                          print("${savedDir}");
                          ControllerAPI.downloadFile(url, replaceBruh, context,
                              "Tersimpan folder download \n Nama File : ${timeStamp}-${DocPPID.toString()}");
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        color: ButtonDownload(sama: status),
                        child: Padding(
                          padding: EdgeInsets.all(20.0.w),
                          child: Row(children: [
                            Icon(
                              Icons.file_copy,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ComponentTextButton(DocPPID == "kosong"
                                ? " ${status}"
                                : " ${DocPPID.toString()}")
                          ]),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: status != "selesai" ? false : true,
                      child: ComponentTextDescriptionBawah(
                          "Silakan Download file , file akan tersimpan dalam device pada folder download"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey,
                    ),
                    // ButtonKeberatan("Keberatan"),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.h),
                      child: ElevatedButton(
                        onPressed: () {
                          if (status == "selesai") {
                            Navigator.pushNamed(context,
                                PageFormulirKeberatanPPID.routeName.toString(),
                                arguments: {
                                  "id_ppid": id_ppid.toString(),
                                  "id_akun": Akunn
                                });
                          } else {
                            ToastWidget.ToastEror(context,
                                "Pengajuan PPID tidak dalam status selesai , tidak dapat melakukan Keberatan");
                          }
                        },
                        child: ComponentTextButton("Keberatan"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(55.h),
                            backgroundColor: Colors.red),
                      ),
                    ),
                    ButtonSelesai("Selesai")
                  ]),
            ),
          ),
        );
      },
    );
  }
}

Color ButtonDownload({String? sama}) {
  if (sama == "diajukan") {
    return Colors.amberAccent;
  } else if (sama == "diproses") {
    return ListColor.warnaBiruSidoKare;
  } else if (sama == "ditolak") {
    return Colors.redAccent;
  } else {
    return Colors.greenAccent;
  }
}

class ButtonKeberatan extends StatelessWidget {
  String? buttonName;
  ButtonKeberatan(this.buttonName);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName);
  }

  Widget _Button(BuildContext context, String? buttonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ElevatedButton(
        onPressed: () {},
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(55.h), backgroundColor: Colors.red),
      ),
    );
  }
}

class ButtonSelesai extends StatelessWidget {
  String? buttonName;
  ButtonSelesai(this.buttonName);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName);
  }

  Widget _Button(BuildContext context, String? buttonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ElevatedButton(
        onPressed: () {},
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
      ),
    );
  }
}

class ComponentTextDescriptionBawah extends StatelessWidget {
  String? textContent;
  TextAlign textAlign = TextAlign.center;
  Color teksColor = Colors.grey;
  ComponentTextDescriptionBawah(this.textContent,
      {this.textAlign = TextAlign.center, this.teksColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textDesc(
        textDesc: textContent.toString(),
        textAlign: textAlign,
        teksColor: this.teksColor);
  }

  Widget _textDesc(
      {String textDesc = "",
      textAlign = TextAlign.start,
      Color teksColor = Colors.grey}) {
    return Text(
      "$textDesc",
      style: FontType.font_utama(
          fontSize: size.sizeDescriptionPas - 1.sp,
          fontWeight: FontWeight.normal,
          color: Colors.grey),
      textAlign: TextAlign.start,
    );
  }
}

class ComponentTextButton extends StatelessWidget {
  String? namaButton;
  ComponentTextButton(this.namaButton);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textDesc(textDesc: namaButton.toString());
  }

  Widget _textDesc({String textDesc = ""}) {
    return Text(
      "$textDesc",
      style: FontType.font_utama(
        color: Colors.white,
        fontSize: size.sizeDescriptionPas.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ComponentTittleCustom extends StatelessWidget {
  String? textContent;
  TextAlign textAlign;
  Color warnaTeks = Colors.black;
  ComponentTittleCustom(this.textContent,
      {this.textAlign = TextAlign.start, this.warnaTeks = Colors.black});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textHeader(
        textHeader_1: textContent.toString(),
        textAlign: textAlign,
        teksColor: warnaTeks);
  }

  Widget _textHeader(
      {Color teksColor = Colors.black,
      String textHeader_1 = "",
      TextAlign textAlign = TextAlign.center}) {
    return Text(
      "$textHeader_1",
      style: FontType.font_utama(
          fontSize: size.sizeDescriptionSedang.sp,
          fontWeight: FontWeight.bold,
          color: teksColor),
      textAlign: this.textAlign,
    );
  }
}
