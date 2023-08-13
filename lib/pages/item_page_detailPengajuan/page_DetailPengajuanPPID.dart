import 'dart:async';
import 'dart:io';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/font_type.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/get/model_jmlkeberatan.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan.dart';
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

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    getData = ModalRoute.of(context)?.settings.arguments as Map;
    String Akunn = getData?['id_akun'];
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
    String emaill = getData?['email'];
    String tlpp = getData?['tlp'];
    String status = getData?['status'];
    print("Status = " + status + " kntl");
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
          body: FutureBuilder<KeberatanPPID>(
            future: KeberatanPPID.getJumlahKeberatanPPID(
                idAKun: Akunn.toString(), idppid: id_ppid),
            builder:
                (BuildContext context, AsyncSnapshot<KeberatanPPID> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
              } else if (snapshot.hasError) {
                return Text("Error : ${snapshot.error}");
              } else {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Detail Data Pengajuan",
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
                                ComponentTextDescription("Email"),
                                ComponentTextDescription("No Telephone"),
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
                                ComponentTextDescription(": ${emaill}"),

                                ComponentTextDescription(": ${tlpp}"),
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
                                ComponentTextDescription(": ${asalPelapor} "),
                                ComponentTextDescription(": ${RT} / ${RW}"),
                                ComponentTextDescription(": ${KategoriPPID}"),
                                Text(
                                  filePendukung.toString().length > 15
                                      ? ": " +
                                          filePendukung
                                              .toString()
                                              .substring(0, 15) +
                                          '...'
                                      : ": ${filePendukung}",
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                            if (status == "Revisi") {
                              ToastWidget.ToastInfo(
                                  context,
                                  "Harap Sabar Masih Di Revisi",
                                  "Proses Penanganan");
                            } else if (DocPPID.toString() != "kosong") {
                              String url =
                                  'http://${ApiPoint.BASE_URL}/storage/app/public/Hasilppids/${DocPPID.toString()}'; // Ganti dengan URL file yang ingin Anda unduh
                              // String savedDir =
                              //     '/storage/emulated/0/Download/${timeStamp}-${DocPPID.toString()}';
                              DateTime currentTime = DateTime.now();
                              DateFormat formatter =
                                  DateFormat('yyyyMMddHHmmss');
                              String timestamp = formatter.format(currentTime);
                              if (Platform.isWindows) {
                                var getDownload = await getDownloadsDirectory();
                                String path =
                                    "${getDownload}\\${timestamp}_${DocPPID.toString()}";
                                String replaceBruh = path.replaceAll("'", "");
                                replaceBruh =
                                    replaceBruh.replaceAll("Directory: ", "");

                                ControllerAPI.normalProgress(
                                  Uri: url,
                                  savePath: replaceBruh,
                                  context: context,
                                );
                              } else if (Platform.isAndroid) {
                                String pathYak =
                                    "/storage/emulated/0/Download/${timestamp}_${DocPPID.toString()}";
                                ControllerAPI.normalProgress(
                                  Uri: url,
                                  savePath: pathYak,
                                  context: context,
                                );
                                ;
                              }
                            } else if (status == 'Ditolak') {
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
                                ComponentTextButton(namaButton(
                                    stss: status,
                                    jml: snapshot.data!.jumlahKeberatanPPID !=
                                            "Kosong"
                                        ? snapshot.data!.jumlahKeberatanPPID
                                            .toString()
                                        : "",
                                    doc: DocPPID.toString()))
                              ]),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: status == "Selesai" || status == "Diterima"
                              ? true
                              : false,
                          child: ComponentTextDescriptionBawah(
                              "Silakan Download file , file akan tersimpan dalam device pada folder download"),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        // Divider(
                        //   height: 1.h,
                        //   color: Colors.grey,
                        // ),
                        // ButtonKeberatan("Keberatan"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    int batasan =
                                        snapshot.data!.jumlahKeberatanPPID !=
                                                "Kosong"
                                            ? snapshot.data!.jumlahKeberatanPPID
                                                .toInt()
                                            : 0;
                                    if (batasan == 2) {
                                      ToastWidget.ToastInfo(
                                          context,
                                          "Revisi sudah kedua kali, silahkan datang ke kantor Desa untuk mendapatkan informasi lebih lanjut",
                                          "Mohon Maaf ");
                                    } else if (status == "Diterima") {
                                      ToastWidget.ToastInfo(
                                          context,
                                          "Tidak dapat lagi mengajukan keberatan",
                                          "Mohon Maaf");
                                    } else if (status == "Ditolak") {
                                      ToastWidget.ToastInfo(
                                          context,
                                          "Pengajuan Ditolak silakan membuat pengajuan kembali",
                                          "Pengajuan Ditolak");
                                    } else {
                                      if (status == "Selesai") {
                                        Navigator.pushNamed(
                                            context,
                                            PageFormulirKeberatanPPID.routeName
                                                .toString(),
                                            arguments: {
                                              "id": id_ppid.toString(),
                                              "id_akun": Akunn,
                                              "kategori": "ppid"
                                            });
                                      } else {
                                        ToastWidget.ToastInfo(
                                            context,
                                            "Pengajuan PPID tidak dalam status selesai , tidak dapat melakukan Keberatan",
                                            "Mohon Maaf");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Keberatan",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(color: Colors.redAccent),
                                      elevation: 0,
                                      foregroundColor:
                                          Colors.redAccent.shade200,
                                      backgroundColor: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: ButtonSelesai(
                                      "Selesai", id_ppid.toString(), status))
                            ],
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 0.h),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       int batasan =
                        //           snapshot.data!.jumlahKeberatanPPID != "Kosong"
                        //               ? snapshot.data!.jumlahKeberatanPPID
                        //                   .toInt()
                        //               : 0;
                        //       if (batasan == 2) {
                        //         ToastWidget.ToastInfo(
                        //             context,
                        //             "Revisi sudah kedua kali, silahkan datang ke kantor Desa untuk mendapatkan informasi lebih lanjut",
                        //             "Mohon Maaf ");
                        //       } else if (status == "Diterima") {
                        //         ToastWidget.ToastInfo(
                        //             context,
                        //             "Tidak dapat lagi mengajukan keberatan",
                        //             "Mohon Maaf");
                        //       } else if (status == "Ditolak") {
                        //         ToastWidget.ToastInfo(
                        //             context,
                        //             "Pengajuan Ditolak silakan membuat pengajuan kembali",
                        //             "Pengajuan Ditolak");
                        //       } else {
                        //         if (status == "Selesai") {
                        //           Navigator.pushNamed(
                        //               context,
                        //               PageFormulirKeberatanPPID.routeName
                        //                   .toString(),
                        //               arguments: {
                        //                 "id": id_ppid.toString(),
                        //                 "id_akun": Akunn,
                        //                 "kategori": "ppid"
                        //               });
                        //         } else {
                        //           ToastWidget.ToastInfo(
                        //               context,
                        //               "Pengajuan PPID tidak dalam status selesai , tidak dapat melakukan Keberatan",
                        //               "Mohon Maaf");
                        //         }
                        //       }
                        //     },
                        //     child: ComponentTextButton("Keberatan"),
                        //     style: ElevatedButton.styleFrom(
                        //         minimumSize: Size.fromHeight(55.h),
                        //         backgroundColor: Colors.red),
                        //   ),
                        // ),
                        // ButtonSelesai("Selesai", id_ppid.toString(), status)
                      ]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

String namaButton({String? stss, String? jml, String? doc}) {
  if (stss == "Revisi") {
    print("${jml} adalahh berapa");
    return "Revisi ${jml}";
  } else if (stss == "Diterima") {
    return " ${doc.toString()}";
  } else if (stss != "Selesai") {
    return " ${stss}";
  } else {
    return " ${doc.toString()}";
  }
}

Color ButtonDownload({String? sama}) {
  if (sama == "Diajukan") {
    return Colors.amberAccent;
  } else if (sama == "Diproses") {
    return ListColor.warnaBiruSidoKare;
  } else if (sama == "Ditolak") {
    return Colors.redAccent;
  } else if (sama == "Revisi") {
    return Colors.pinkAccent;
  } else if (sama == "Selesai") {
    return Colors.lightGreen;
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
  String? idppid;
  String? stss;
  ButtonSelesai(this.buttonName, this.idppid, this.stss);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName, idppid, stss);
  }

  Widget _Button(
      BuildContext context, String? buttonName, String? idppid, String? stss) {
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
                  content: Text('Yakin Menerima Informasi PPID?'),
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
                        print("ID PPID == ${idppid}");
                        PengajuanPPID.AccPPID(idppid).then((value) => {
                              if (value.code == 200)
                                {
                                  ToastWidget.ToastInfo(
                                      context,
                                      "Terima Kasih telah menerima PPID",
                                      "Terima Kasih"),

                                  Navigator.of(context).pop(), // Menutup dialog
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
          } else if (stss == "Diterima") {
            ToastWidget.ToastInfo(context, "PPID telah disetujui", "Informasi");
          } else if (stss == "Ditolak") {
            ToastWidget.ToastInfo(
                context,
                "Pengajuan Ditolak silakan membuat pengajuan kembali",
                "Pengajuan Ditolak");
          } else {
            ToastWidget.ToastInfo(context,
                "Mohon tunngu pembuatan dokumen ppid", "Mohon Tungggu");
          }
        },
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(),
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
