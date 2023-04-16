import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_aspirasi.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';

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
  TextEditingController? uploadFile = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final idAkunnn = ModalRoute.of(context)?.settings.arguments as int;
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
                    "Formulir Pengajuan Keluhan",
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
                            text_kontrol: textEditingControllerNamaLengkap,
                            hintText: "Masukkan Nama Anda",
                            labelName: "Nama Lengkap",
                            pesanValidasi: "Nama")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: TextFieldImport.TextForm(
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
                        child: TextFieldImport.TextForm(
                            text_kontrol: textEditingControllerIsiAspirasi,
                            hintText: "Masukkan Isi Aspirasi",
                            labelName: "Isi Aspirasi",
                            pesanValidasi: "Isi Aspirasi")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: TextFieldImport.TextForm(
                            text_kontrol: uploadFile,
                            hintText: "Unggah File Pendukung",
                            labelName: "Upload File Pendukung",
                            pesanValidasi: "File Pendukung")),
                  ),
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
                                    uploadFile!.text)
                                .then((value) => {
                                      if (value.code == 200)
                                        {print("Kenek Aspirasi")}
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
}
