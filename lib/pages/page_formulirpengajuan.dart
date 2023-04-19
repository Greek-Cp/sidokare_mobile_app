import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan.dart';

import '../provider/provider_account.dart';

class PageFormulirPengajuanPPID extends StatefulWidget {
  static String routeName = "/formulir_pengajuan";
  @override
  State<PageFormulirPengajuanPPID> createState() =>
      _PageFormulirPengajuanState();
}

class _PageFormulirPengajuanState extends State<PageFormulirPengajuanPPID> {
  TextEditingController? textEditingControllerNamaLengkap =
      TextEditingController();
  TextEditingController? fileUp = TextEditingController();
  TextEditingController? textEditingControllerNIK = TextEditingController();
  TextEditingController? textEditingControllerJudulLaporan =
      TextEditingController();
  TextEditingController? textEditingControllerIsiLaporan =
      TextEditingController();
  TextEditingController? textEditingControllerAsalPelapor =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static File? _file;
  final List<String> listDusun = ['Sidokare', 'SidoMaju', 'SidoSido'];
  final List<String> listPPID = ['PPID keren', 'PPID PDIP', 'PPID TEST'];
  static String? randomValuePPID = "PPID keren";
  static String? randomValueDusun = "Sidokare";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    "Formulir Pengajuan PPID",
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
                            labelName: "Nama",
                            pesanValidasi: "Nama")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: TextFieldImport.TextForm(
                            readyOnlyTydack: true,
                            text_kontrol: textEditingControllerNIK,
                            hintText: "Masukan Nik Anda",
                            labelName: "NIK",
                            pesanValidasi: "NIK")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: TextFieldImport.TextForm(
                            text_kontrol: textEditingControllerJudulLaporan,
                            hintText: "Masukkan Judul Laporan",
                            labelName: "Judul Laporan",
                            pesanValidasi: "Judul Laporan")),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: TextFieldImport.TextForm(
                            text_kontrol: textEditingControllerIsiLaporan,
                            hintText: "Masukkan Isi Laporan",
                            labelName: "Isi Laporan",
                            pesanValidasi: "Isi Laporan")),
                  ),
                  customDropDownDusun(
                      listItem: listDusun,
                      namaLabel: "Asal Pelapor",
                      hintText: "Pilih Dusun",
                      randomlabel: randomValueDusun,
                      errorKosong: "Dusun"),
                  customDropDownPPID(
                    listItem: listPPID,
                    namaLabel: "Kategori PPID",
                    hintText: "Pilih Kategori",
                    errorKosong: "PPID",
                    randomlabel: randomValuePPID,
                  ),
                  UpfilePendukung("Upload File Pendukung", "gatau", fileUp!,
                      "Silakan Upload File"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ListColor.warnaBiruSidoKare,
                            minimumSize: Size.fromHeight(55.h)),
                        onPressed: () => {
                              print("Jenis PPID == ${randomValuePPID}"),
                              print("Dusun Terpilih == ${randomValueDusun}"),
                              print("IdAkunnyaa == ${idAkunnn.toString()}"),
                              if (_formKey.currentState!.validate())
                                {
                                  print(
                                      "Tes file :: " + fileUp!.text.toString()),
                                  PengajuanPPID.InsertDataPPID(
                                          idAkun: idAkunnn.toString(),
                                          JudulLaporan:
                                              textEditingControllerJudulLaporan!
                                                  .text,
                                          isiLaporan:
                                              textEditingControllerIsiLaporan!
                                                  .text,
                                          asalLaporan:
                                              randomValueDusun.toString(),
                                          kategoriPPID:
                                              randomValuePPID.toString(),
                                          File: fileUp!.text.toString())
                                      .then((value) => {
                                            if (value.code == 200)
                                              {
                                                print("Kenek paleng"),
                                                if (fileUp!.text.toString() !=
                                                    "")
                                                  {
                                                    PengajuanPPID
                                                            .uploadFilePPID(
                                                                _file!)
                                                        .then((value) => {}),
                                                  },
                                              }
                                            else
                                              {print("yahaha gagal")}
                                          })
                                }
                              else
                                {}
                            },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Ajukan PPID",
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

  Future<void> _pickFile() async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   setState(() {
    //     _file = File(pickedFile.path);

    //     fileUp?.text = pickedFile.path;
    //   });
    // }
  }

  Widget UpfilePendukung(String labelName, String pesanValidasi,
      TextEditingController text_kontrol, String hintText) {
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
            // validator: (value) {
            //   if (value!.isEmpty || value == null) {
            //     return "${pesanValidasi} Tidak Boleh Kosong";
            //   }
            // },
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
                      fileUp?.text = namaFile.name.toString();
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

  Widget customDropDownPPID(
      {List<String>? listItem,
      String? namaLabel,
      String? hintText,
      String? randomlabel,
      String? errorKosong}) {
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
            "$namaLabel",
            style: GoogleFonts.dmSans(
                textStyle:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13.sp)),
            textAlign: TextAlign.start,
          ),
          DropdownButtonFormField2(
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding:
                  EdgeInsets.only(bottom: 1.0.h, top: 1.0.h, right: 5.0.w),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              '$hintText',
              style: TextStyle(fontSize: 14.sp),
            ),
            items: listItem
                ?.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Harap Memilih $errorKosong !.';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                randomValuePPID = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50.h,
              padding: EdgeInsets.only(right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDropDownDusun(
      {List<String>? listItem,
      String? namaLabel,
      String? hintText,
      String? randomlabel,
      String? errorKosong}) {
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
            "$namaLabel",
            style: GoogleFonts.dmSans(
                textStyle:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 13.sp)),
            textAlign: TextAlign.start,
          ),
          DropdownButtonFormField2(
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding:
                  EdgeInsets.only(bottom: 1.0.h, top: 1.0.h, right: 5.0.w),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              '$hintText',
              style: TextStyle(fontSize: 14.sp),
            ),
            items: listItem
                ?.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Harap Memilih $errorKosong !.';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                randomValueDusun = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50.h,
              padding: EdgeInsets.only(right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
