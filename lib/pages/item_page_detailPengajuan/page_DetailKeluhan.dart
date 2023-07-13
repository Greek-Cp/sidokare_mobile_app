import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/get/model_jmlkeluhan.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_keluhan.dart';
import 'package:sidokare_mobile_app/pages/item_page_detailPengajuan/page_DetailPengajuanPPID.dart';

import '../../component/Toast.dart';
import '../../component/text_description.dart';
import '../../const/const.dart';
import '../../const/font_type.dart';
import '../../const/list_color.dart';
import '../../model/response/get/controller_get.dart';
import '../../provider/provider_account.dart';
import '../page_formulirKeberatan.dart';

class PageDetailKeluhann extends StatefulWidget {
  static String? routeName = "/DetailPengajuhanKeluhann2";
  @override
  State<PageDetailKeluhann> createState() => _PageDetailKeluhannState();
}

Color? warnaButton({String? samakan}) {
  if (samakan == "diajukan") {
    return Colors.amberAccent;
  } else if (samakan == "diproses") {
    ListColor.GradientwarnaBiruSidoKare;
  } else if (samakan == "ditolak") {
    return Colors.redAccent;
  } else if (samakan == "revisi") {
    return Colors.pinkAccent;
  } else if (samakan == "direview") {
    return Colors.orangeAccent;
  } else if (samakan == "selesai") {
    return Colors.lightGreen;
  } else {
    return Colors.greenAccent;
  }
}

class _PageDetailKeluhannState extends State<PageDetailKeluhann> {
  Map? getDataKeluhan;
  @override
  Widget build(BuildContext context) {
    getDataKeluhan = ModalRoute.of(context)?.settings.arguments as Map;
    int Akunn = getDataKeluhan?['id_akun'];
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == Akunn);

    String JudulLaporan = getDataKeluhan?['judulLaporan'];
    String isiLaporan = getDataKeluhan?['isiLaporan'];
    String AsalPelapor = getDataKeluhan?['AsalPelapor'];
    String RTuser = getDataKeluhan?['RT'];
    String RWuser = getDataKeluhan?['RW'];
    String DokumenUser = getDataKeluhan?['docOutAsp'];
    String LokasiKejadian = getDataKeluhan?['LokasiKejadian'];
    String KategoriLaporan = getDataKeluhan?['KategoriLaporan'];
    String tanggalKejadian = getDataKeluhan?['TanggalKejadian'];
    String UploadFilePendukung = getDataKeluhan?['uploadFile'];
    String stsss = getDataKeluhan?['statuss'];

    String idMengeluh = getDataKeluhan?['id_keluhan'];

    print("isi Laporan == ${isiLaporan}");
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
            title: ComponentTextTittle("Detail Pengajuan Keluhan"),
          ),
          body: FutureBuilder<KeberatanKeluhan>(
            future: KeberatanKeluhan.getJumlahKeberatanKeluhan(
                idAKun: Akunn.toString(), idKeluhan: idMengeluh),
            builder: (context, snapshot) {
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
                        "Detail Data Pengaju",
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
                              // ComponentTextDescription(": ${DataDiri.nama}"),
                              ComponentTextDescription(": ${DataDiri.Nik}"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ComponentTextDescription("Judul Keluhan"),
                      ComponentTittleCustom(
                        "${JudulLaporan}",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ComponentTextDescription("Isi Keluhan"),
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
                        height: 10.h,
                      ),
                      ComponentTextDescription("Lokasi Pelapor"),
                      Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: Container(
                            width: double.infinity,
                            child: ComponentTextDescription(
                              "${LokasiKejadian}",
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
                              ComponentTextDescription("Asal Pelapor"),
                              ComponentTextDescription("RT / RW"),
                              ComponentTextDescription("Kategori Laporan"),
                              ComponentTextDescription("Upload File Pendukung"),
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ComponentTextDescription(": ${AsalPelapor} "),
                              ComponentTextDescription(
                                  ": ${RTuser} / ${RWuser}"),
                              ComponentTextDescription(": ${KategoriLaporan}"),
                              ComponentTextDescription(
                                  namaFile(tess: UploadFilePendukung)),
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
                      ComponentTextDescription("Hasil Keluhan: "),
                      GestureDetector(
                        onTap: () async {
                          print("halooo");
                          if (stsss == "revisi") {
                            ToastWidget.ToastInfo(
                                context,
                                "Harap Sabar Masih Di Revisi",
                                "Proses Penanganan");
                          } else if (DokumenUser.toString() != "kosong") {
                            String url =
                                'http://${ApiPoint.BASE_URL}/storage/HasilKeluhan/${DokumenUser.toString()}'; // Ganti dengan URL file yang ingin Anda unduh
                            // String savedDir =
                            //     '/storage/emulated/0/Download/${timeStamp}-${DocPPID.toString()}';
                            DateTime currentTime = DateTime.now();
                            DateFormat formatter = DateFormat('yyyyMMddHHmmss');
                            String timestamp = formatter.format(currentTime);
                            if (Platform.isWindows) {
                              var getDownload = await getDownloadsDirectory();
                              String path =
                                  "${getDownload}\\${timestamp}_${DokumenUser.toString()}";
                              String replaceBruh = path.replaceAll("'", "");
                              replaceBruh =
                                  replaceBruh.replaceAll("Directory: ", "");
                              // print(replaceBruh);
                              // String savedDir =
                              //     "C:\\Users\\LENOVO\\Downloads\\Named123_ppid677.pdf";
                              // print("${savedDir}");
                              ControllerAPI.downloadFile(
                                  url,
                                  replaceBruh,
                                  context,
                                  "Tersimpan folder download \n Nama File : ${timestamp}-${DokumenUser.toString()}");
                            } else if (Platform.isAndroid) {
                              String pathYak =
                                  "/storage/emulated/0/Download/${timestamp}_${DokumenUser.toString()}";
                              ControllerAPI.downloadFile(url, pathYak, context,
                                  "Tersimpan folder download \n Nama File : ${timestamp}-${DokumenUser.toString()}");
                            }
                          } else if (stsss == 'ditolak') {
                            ToastWidget.ToastInfo(
                                context,
                                "harap ajukan kembali dan Pastikan data yang dimasukkan benar",
                                "Pengajuan Ditolak");
                          } else {
                            ToastWidget.ToastInfo(
                                context, "Belum, Bisa", "Sabar");
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          color: ButtonDownload(sama: stsss),
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
                                  stss: stsss,
                                  jml: snapshot.data!.jumlahKeberatanKeluhan !=
                                          "Kosong"
                                      ? snapshot.data!.jumlahKeberatanKeluhan
                                          .toString()
                                      : "",
                                  doc: DokumenUser.toString()))
                            ]),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: stsss == "selesai" || stsss == "diterima"
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
                            int batasan = snapshot
                                        .data!.jumlahKeberatanKeluhan !=
                                    "Kosong"
                                ? snapshot.data!.jumlahKeberatanKeluhan.toInt()
                                : 0;

                            if (batasan == 2) {
                              ToastWidget.ToastInfo(
                                  context,
                                  "Revisi sudah kedua kali, silahkan datang ke kantor Desa untuk mendapatkan informasi lebih lanjut",
                                  "Mohon Maaf ");
                            } else if (stsss == "diterima") {
                              ToastWidget.ToastInfo(
                                  context,
                                  "Tidak dapat lagi mengajukan keberatan",
                                  "Mohon Maaf");
                            } else {
                              if (stsss == "selesai") {
                                // print("ID ASPIRASI == ${idAspirasi}");
                                Navigator.pushNamed(
                                    context,
                                    PageFormulirKeberatanPPID.routeName
                                        .toString(),
                                    arguments: {
                                      "id": idMengeluh,
                                      "id_akun": Akunn,
                                      "kategori": "keluhan"
                                    });
                              } else if (stsss == "ditolak") {
                                ToastWidget.ToastInfo(
                                    context,
                                    "Pengajuan Ditolak silakan membuat pengajuan kembali",
                                    "Pengajuan Ditolak");
                              } else {
                                ToastWidget.ToastInfo(
                                    context,
                                    "Pengajuan Keluhan tidak dalam status selesai , tidak dapat melakukan Keberatan",
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
                      ButtonSelesai("Selesai", idMengeluh, stsss)
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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

  String namaFile({String? tess}) {
    if (tess.toString().length > 20) {
      return ": " + tess.toString().substring(0, 20) + '...';
    } else if (tess == "") {
      return ": Kosong";
    } else {
      return ": " + tess.toString();
    }
  }
}

class ButtonSelesai extends StatelessWidget {
  String? buttonName;
  String? idkeluhan;
  String? stss;
  ButtonSelesai(this.buttonName, this.idkeluhan, this.stss);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName, idkeluhan, stss);
  }

  Widget _Button(BuildContext context, String? buttonName, String? idkeluhan,
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
                        print("ID PPID == ${idkeluhan}");
                        PengajuhanKeluhan.AccKeluhan(idkeluhan)
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
                context, "Formulir Keluhan telah disetujui", "Informasi");
          } else if (stss == "ditolak") {
            ToastWidget.ToastInfo(
                context,
                "Pengajuan Ditolak silakan membuat pengajuan kembali",
                "Pengajuan Ditolak");
          } else {
            ToastWidget.ToastInfo(
                context,
                "Mohon tunngu pembuatan dokumen Pengajuan Keluhan",
                "Mohon Tungggu");
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
