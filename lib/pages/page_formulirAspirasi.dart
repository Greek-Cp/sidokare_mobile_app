import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/LoadingComponent.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_aspirasi.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';
import '../provider/provider_account.dart';

class PageFormulirAspirasi extends StatefulWidget {
  static String routeName = "/formulir_pengajuanAspirasi";
  @override
  State<PageFormulirAspirasi> createState() => _PageFormulirAspirasiState();
}

class _PageFormulirAspirasiState extends State<PageFormulirAspirasi> {
  TextEditingController? textEditingControllerNamaLengkap =
      TextEditingController();
  TextEditingController? textEditingControllerNIK = TextEditingController();
  TextEditingController? textEditingControllerJudulAspirasi =
      TextEditingController();
  TextEditingController? textEditingControllerIsiAspirasi =
      TextEditingController();
  TextEditingController? fileUp = TextEditingController();
  File? _file;
  TextEditingController? uploadFile = TextEditingController();
  bool statusPengajuan = false;

  final _formKey = GlobalKey<FormState>();

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
    final idAkunnn = ModalRoute.of(context)?.settings.arguments as int;
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == idAkunnn);

    setState(() {
      textEditingControllerNIK!.text = DataDiri.Nik.toString();
      textEditingControllerNamaLengkap!.text = DataDiri.nama.toString();
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return statusPengajuan == true
            ? LoadingComponent(
                prosesName: "aspirasi",
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    "Formulir Pengajuan Aspirasi",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextForm(
                                readyOnlyTydack: true,
                                text_kontrol: textEditingControllerNamaLengkap,
                                hintText: "Masukkan Nama Anda",
                                labelName: "Nama Lengkap",
                                pesanValidasi: "Nama")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextForm(
                                readyOnlyTydack: true,
                                text_kontrol: textEditingControllerNIK,
                                hintText: "Masukan NIK Anda",
                                labelName: "NIK",
                                pesanValidasi: "NIK")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextForm(
                                text_kontrol:
                                    textEditingControllerJudulAspirasi,
                                hintText: "Masukkan Judul Aspirasi",
                                labelName: "Judul Aspirasi",
                                pesanValidasi: "Judul Aspirasi")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextFormMultiLine(
                                text_kontrol: textEditingControllerIsiAspirasi,
                                hintText: "Masukkan Isi Aspirasi",
                                labelName: "Isi Aspirasi",
                                pesanValidasi: "Isi Aspirasi")),
                      ),
                      UpfilePendukung(
                          labelName: "Upload File Pendukung (Max: 2Mb)",
                          pesanValidasi: "Boleh Kosong",
                          text_kontrol: fileUp!,
                          hintText: "boleh dikosongi"),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ListColor.warnaBiruSidoKare,
                                minimumSize: Size.fromHeight(55.h)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("ID AKUN :: ${idAkunnn}");
                                print(
                                    "JUDUL ASPIRASI :: ${textEditingControllerJudulAspirasi!.text}");
                                print(
                                    "ISI ASPIRASI :: ${textEditingControllerIsiAspirasi!.text}");
                                print("FILE UPLOAD :: ${fileUp!.text}");

                                if (fileUp!.text.toString() != "") {
                                  int sizeInBytes = _file!.lengthSync();
                                  double sizeInMb = sizeInBytes / (1024 * 1024);

                                  if (sizeInMb > 2) {
                                    ToastWidget.ToastInfo(
                                        context,
                                        "Maksimal file yang dapat upload 2MB",
                                        "File Terlalu Besar");
                                  } else {
                                    //Dengan File
                                    setState(() {
                                      statusPengajuan = true;
                                    });
                                    PengajuanAspirasi.InsertAspirasi(
                                            idAkunnn.toString(),
                                            textEditingControllerJudulAspirasi!
                                                .text,
                                            textEditingControllerIsiAspirasi!
                                                .text,
                                            fileUp!.text)
                                        .then((value) => {
                                              if (value.code == 200)
                                                {
                                                  print(
                                                      "Kenek Aspirasi Dengan File"),
                                                  PengajuanAspirasi
                                                          .uploadFileAspirasi(
                                                              _file!)
                                                      .then((value) => {
                                                            Navigator.popAndPushNamed(
                                                                context,
                                                                BerhasilBuatLaporan
                                                                    .routeName
                                                                    .toString(),
                                                                arguments: idAkunnn
                                                                    .toString())
                                                          })
                                                }
                                              else
                                                {print("gagal aspirasi")}
                                            });
                                  }
                                } else {
                                  //file tidak ada
                                  print("halo");
                                  setState(() {
                                    statusPengajuan = true;
                                  });
                                  PengajuanAspirasi.InsertAspirasi(
                                          idAkunnn.toString(),
                                          textEditingControllerJudulAspirasi!
                                              .text,
                                          textEditingControllerIsiAspirasi!
                                              .text,
                                          fileUp!.text)
                                      .then((value) => {
                                            if (value.code == 200)
                                              {
                                                print(
                                                    "Kenek Aspirasi Tanpa File"),
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    BerhasilBuatLaporan
                                                        .routeName
                                                        .toString(),
                                                    arguments:
                                                        idAkunnn.toString())
                                              }
                                            else
                                              {print("gagal aspirasi")}
                                          });
                                }
                              } else {
                                setState(() {
                                  statusPengajuan = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Ajukan Aspirasi",
                                style: TextStyle(fontSize: size.textButton.sp),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 80.h,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget UpfilePendukung(
      {String? labelName,
      String? pesanValidasi,
      TextEditingController? text_kontrol,
      String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "${labelName}",
            style: GoogleFonts.dmSans(
                textStyle:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13.sp)),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5.h,
          ),
          TextFormField(
            controller: text_kontrol,
            readOnly: true,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    // _pickFile();
                    final FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.custom, allowedExtensions: [
                      'pdf',
                      'docx',
                      'jpg',
                      'jpeg',
                      'png'
                    ]);

                    if (result != null) {
                      _file = File(result.files.single.path!);
                      PlatformFile namaFile = result.files.first;
                      text_kontrol?.text = namaFile.name.toString();
                    }
                  },
                  child: Icon(Icons.file_upload),
                ),
                hintText: hintText,
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: ListColor.warnaBiruSidoKare),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: ListColor.warnaBiruSidoKare),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: ListColor.warnaBiruSidoKare),
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ],
      ),
    );
  }
}
