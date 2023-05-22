import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/get/model_jmlaspirasi.dart';
import 'package:sidokare_mobile_app/model/response/get/model_jmlkeberatan.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_aspirasi.dart';
import 'package:sidokare_mobile_app/pages/item_page_detailPengajuan/page_DetailPengajuanPPID.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../component/Toast.dart';
import '../../component/text_description.dart';
import '../../const/const.dart';
import '../../const/font_type.dart';
import '../../const/list_color.dart';
import '../../model/response/get/controller_get.dart';
import '../page_formulirKeberatan.dart';

class PageDetailAspirasiiii extends StatefulWidget {
  static String? routeName = "/DetailPengajuanAspirasi2";
  @override
  State<PageDetailAspirasiiii> createState() => _PageDetailAspirasiState();
}

Color ButtonDownloadAspirasi({String? sama}) {
  if (sama == "diajukan") {
    return Colors.amberAccent;
  } else if (sama == "diproses") {
    return ListColor.warnaBiruSidoKare;
  } else if (sama == "ditolak") {
    return Colors.redAccent;
  } else if (sama == "revisi") {
    return Colors.pinkAccent;
  } else if (sama == "selesai") {
    return Colors.lightGreen;
  } else {
    return Colors.greenAccent;
  }
}

String namaButton({String? stss, String? jml, String? doc}) {
  if (stss == "revisi") {
    print("${jml} adalahh berapa");
    return "Revisi ${jml}";
  } else if (stss == "diterima") {
    return " ${doc.toString()}";
  } else if (stss != "selesai") {
    return " ${stss}";
  } else {
    return " ${doc.toString()}";
  }
}

class _PageDetailAspirasiState extends State<PageDetailAspirasiiii> {
  Map? getDataAspirasi;
  @override
  Widget build(BuildContext context) {
    getDataAspirasi = ModalRoute.of(context)?.settings.arguments as Map;
    int Akunn = getDataAspirasi?['id_akun'];
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == Akunn);
    String stts = getDataAspirasi?['status'];
    String JudulLaporan = getDataAspirasi?['judulLaporan'];
    String isiLaporan = getDataAspirasi?['isiLaporan'];
    String filePendukung = getDataAspirasi?['uploadFile'];
    String idAspirasi = getDataAspirasi?['id_aspirasi'];
    String DocAspirasi = getDataAspirasi?['docOutAsp'];

    String namaFile({String? tess}) {
      if (tess.toString().length > 20) {
        return " : " + tess.toString().substring(0, 20) + '...';
      } else if (tess == "") {
        return " : Kosong";
      } else {
        return " : " + tess.toString();
      }
    }

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
              title: ComponentTextTittle("Detail Pengajuan Aspirasi"),
            ),
            body: FutureBuilder<KeberatanAspirasi>(
              future: KeberatanAspirasi.getJumlahKeberatanAspirasi(
                  idAKun: Akunn.toString(), id_aspirasi: idAspirasi.toString()),
              builder: (BuildContext context,
                  AsyncSnapshot<KeberatanAspirasi> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Detail Data Pengajuan ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.sizeDescriptionPas.sp),
                        ),
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
                          "${JudulLaporan}",
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
                        Text(
                          "Data Lainnya",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.sizeDescriptionPas.sp),
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentTextDescription(
                                    "Upload File Pendukung"),
                              ],
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentTextDescription(
                                    namaFile(tess: filePendukung)),
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
                        ComponentTextDescription("Hasil Aspirasi: "),
                        GestureDetector(
                          onTap: () async {
                            print("halooo");
                            if (stts == "revisi") {
                              ToastWidget.ToastInfo(
                                  context,
                                  "Harap Sabar Masih Di Revisi",
                                  "Proses Penanganan");
                            } else if (DocAspirasi.toString() != "kosong") {
                              String url =
                                  'http://${ApiPoint.BASE_URL}/storage/dummyOutput/${DocAspirasi.toString()}'; // Ganti dengan URL file yang ingin Anda unduh
                              // String savedDir =
                              //     '/storage/emulated/0/Download/${timeStamp}-${DocPPID.toString()}';
                              DateTime currentTime = DateTime.now();
                              DateFormat formatter =
                                  DateFormat('yyyyMMddHHmmss');
                              String timestamp = formatter.format(currentTime);
                              if (Platform.isWindows) {
                                var getDownload = await getDownloadsDirectory();
                                String path =
                                    "${getDownload}\\${timestamp}_${DocAspirasi.toString()}";
                                String replaceBruh = path.replaceAll("'", "");
                                replaceBruh =
                                    replaceBruh.replaceAll("Directory: ", "");
                                print(replaceBruh);
                                // String savedDir =
                                //     "C:\\Users\\LENOVO\\Downloads\\Named123_ppid677.pdf";
                                // print("${savedDir}");
                                ControllerAPI.downloadFile(
                                    url,
                                    replaceBruh,
                                    context,
                                    "Tersimpan folder download \n Nama File : ${timestamp}-${DocAspirasi.toString()}");
                              } else if (Platform.isAndroid) {
                                String pathYak =
                                    "/storage/emulated/0/Download/${timestamp}_${DocAspirasi.toString()}";
                                ControllerAPI.downloadFile(
                                    url,
                                    pathYak,
                                    context,
                                    "Tersimpan folder download \n Nama File : ${timestamp}-${DocAspirasi.toString()}");
                              }
                            } else {
                              ToastWidget.ToastInfo(
                                  context, "Belum, Bisa", "Sabar");
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            color: ButtonDownloadAspirasi(sama: stts),
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
                                ComponentTextButton(namaButton(
                                    stss: stts,
                                    jml: snapshot.data!
                                                .JumlahKeberatanAspirasi !=
                                            "Kosong"
                                        ? snapshot.data!.JumlahKeberatanAspirasi
                                        : "",
                                    doc: DocAspirasi.toString()))
                              ]),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: stts == "selesai" || stts == "diterima"
                              ? true
                              : false,
                          child: ComponentTextDescriptionBawah(
                              "Silakan Download file , file akan tersimpan dalam device pada folder download"),
                        ),
                        Divider(
                          color: Colors.grey,
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
                              int batasan =
                                  snapshot.data!.JumlahKeberatanAspirasi !=
                                          "Kosong"
                                      ? snapshot.data!.JumlahKeberatanAspirasi
                                          .toInt()
                                      : 0;

                              if (batasan == 2) {
                                ToastWidget.ToastInfo(
                                    context,
                                    "Revisi sudah kedua kali, silahkan datang ke kantor Desa untuk mendapatkan informasi lebih lanjut",
                                    "Mohon Maaf ");
                              } else if (stts == "diterima") {
                                ToastWidget.ToastInfo(
                                    context,
                                    "Tidak dapat lagi mengajukan keberatan",
                                    "Mohon Maaf");
                              } else {
                                if (stts == "selesai") {
                                  print("ID ASPIRASI == ${idAspirasi}");
                                  Navigator.pushNamed(
                                      context,
                                      PageFormulirKeberatanPPID.routeName
                                          .toString(),
                                      arguments: {
                                        "id": idAspirasi,
                                        "id_akun": Akunn,
                                        "kategori": "aspirasi"
                                      });
                                } else {
                                  ToastWidget.ToastInfo(
                                      context,
                                      "Pengajuan PPID tidak dalam status selesai , tidak dapat melakukan Keberatan",
                                      "Mohon Maaf");
                                }
                              }
                            },
                            child: ComponentTextButton("Keberatan"),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(55.h),
                                backgroundColor: Colors.red),
                          ),
                        ),
                        ButtonSelesai("Selesai", idAspirasi, stts)
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}

class ButtonSelesai extends StatelessWidget {
  String? buttonName;
  String? idaspirasi;
  String? stss;

  ButtonSelesai(this.buttonName, this.idaspirasi, this.stss);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName, idaspirasi, stss);
  }

  Widget _Button(BuildContext context, String? buttonName, String? idaspirasi,
      String? stss) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ElevatedButton(
        onPressed: () {
          if (stss == "selesai") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Konfirmasi'),
                  content: Text('Yakin Menerima Informasi Tentang Keluhan?'),
                  actions: [
                    TextButton(
                      child: Text('batal'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        print("ID PPID == ${idaspirasi}");
                        PengajuanAspirasi.AccAspirasi(idaspirasi)
                            .then((value) => {
                                  if (value.code == 200)
                                    {
                                      // ToastWidget.ToastInfo(
                                      //     context,
                                      //     "Terima Kasih telah menerima Keluhan",
                                      //     "Terima Kasih"),

                                      Navigator.of(context)
                                          .pop(), // Menutup dialog
                                      Navigator.of(context).pop(true),
                                    }
                                  else
                                    {print('gagal')}
                                });
                      },
                    ),
                  ],
                );
              },
            );
          } else if (stss == "diterima") {
            ToastWidget.ToastInfo(
                context, "Aspirasi telah disetujui", "Informasi");
          } else {
            ToastWidget.ToastInfo(context,
                "Mohon tunggu pembuatan dokumen Aspirasi", "Mohon Tungggu");
          }
        },
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
      ),
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
