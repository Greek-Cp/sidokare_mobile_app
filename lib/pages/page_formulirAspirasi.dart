import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

  final _formKey = GlobalKey<FormState>();

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
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => {Navigator.pop(context)},
                ),
                snap: false,
                floating: true,
                stretch: true,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: ListColor.warnaBiruSidoKare,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Formulir Pengajuan Aspirasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size.HeaderText.sp),
                  ),
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 50.0.h, bottom: 18.0.h),
                  collapseMode: CollapseMode.parallax,
                  background: Card(color: ListColor.GradientwarnaBiruSidoKare),
                ),
              ),
              Form(
                key: _formKey,
                child: SliverList(
                    delegate: SliverChildListDelegate([
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
                            text_kontrol: textEditingControllerJudulAspirasi,
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
                      labelName: "Upload File Pendukung",
                      pesanValidasi: "Boleh Kosong",
                      text_kontrol: fileUp!,
                      hintText: "Silakan Upload File *opsional"),
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
                            print("FILE UPLOAD :: ${uploadFile!.text}");

                            PengajuanAspirasi.InsertAspirasi(
                                    idAkunnn.toString(),
                                    textEditingControllerJudulAspirasi!.text,
                                    textEditingControllerIsiAspirasi!.text,
                                    fileUp!.text)
                                .then((value) => {
                                      if (value.code == 200)
                                        {
                                          print("Kenek Aspirasi"),
                                          if (fileUp!.text.toString() != "")
                                            {
                                              PengajuanAspirasi
                                                      .uploadFileAspirasi(
                                                          _file!)
                                                  .then((value) => {
                                                        Navigator.pushNamed(
                                                            context,
                                                            BerhasilBuatLaporan
                                                                .routeName
                                                                .toString(),
                                                            arguments: idAkunnn
                                                                .toString())
                                                      })
                                            }
                                          else
                                            {
                                              Navigator.pushNamed(
                                                  context,
                                                  BerhasilBuatLaporan.routeName
                                                      .toString(),
                                                  arguments:
                                                      idAkunnn.toString())
                                            },
                                        }
                                      else
                                        {print("gagal aspirasi")}
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
                ])),
              ),
            ],
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
                    final FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

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
