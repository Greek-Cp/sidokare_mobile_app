import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_keluhan.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';
import 'package:intl/intl.dart';

class PageFormulirPengajuanKeluhan extends StatefulWidget {
  static String routeName = "/formulir_pengajuanKeluhan";

  @override
  State<PageFormulirPengajuanKeluhan> createState() =>
      _PageFormulirPengajuanKeluhanState();
}

class _PageFormulirPengajuanKeluhanState
    extends State<PageFormulirPengajuanKeluhan> {
  TextEditingController? textEditingControllerNamaLengkap =
      TextEditingController();
  TextEditingController? textEditingControllerNIK = TextEditingController();
  TextEditingController? textEditingControllerJudulLaporan =
      TextEditingController();
  TextEditingController? textEditingControllerIsiLaporan =
      TextEditingController();
  TextEditingController? textEditingControllerAsalPelapor =
      TextEditingController();
  TextEditingController? controllerDate = TextEditingController();
  TextEditingController? fileUp = TextEditingController();

  DateTime selectedDate = DateTime.now();
  File? _file;

  @override
  void initState() {
    super.initState();
    // selectedDate = DateTime.now();
  }

  final List<String> listDusun = ['Sidokare', 'SidoMaju', 'SidoSido'];
  final List<String> listKategoriLaporan = [
    'Laporan Hamil',
    'Laporan Pelecehan Seksual',
    'Laporan Kebakaran'
  ];
  static String? randomValueKategoriLaporan = "Laporan Hamil";
  static String? randomValueKejadianDusun = "Sidokare";
  static String? randomValueAsalPelapor = "Sidokare";

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
                  customDropDownLokasiAsalPelapor(
                      listItem: listDusun,
                      namaLabel: "Asal Pelapor",
                      hintText: "pilih lokasi",
                      errorKosong: "pelapor",
                      randomlabel: randomValueAsalPelapor),
                  customDropDownLokasiKejadian(
                      listItem: listDusun,
                      namaLabel: "Lokasi Kejadian",
                      hintText: "Pilih Dusun",
                      errorKosong: "Kejadian",
                      randomlabel: randomValueKejadianDusun),
                  customDropDownKategoriLaporan(
                    listItem: listKategoriLaporan,
                    namaLabel: "Kategori Laporan",
                    hintText: "Pilih Kategori",
                    errorKosong: "Laporan",
                    randomlabel: randomValueKategoriLaporan,
                  ),
                  PilihTanggal("Tanggal Kejadian", "Kejadian", controllerDate!,
                      "Masukkan Tanggal"),
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
                        onPressed: () {
                          String pp =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          print("tanggal nya adalah ${pp}");
                          print(
                              "judul Laporan : ${textEditingControllerJudulLaporan!.text}");
                          print(
                              "isi Laporan : ${textEditingControllerIsiLaporan!.text}");
                          print(
                              "Asal Laporan : ${randomValueAsalPelapor.toString()}");
                          print(
                              "Dusun : ${randomValueKejadianDusun.toString()}");
                          print(
                              "Kategori Laporan : ${randomValueKategoriLaporan.toString()}");
                          print("ID AKUN :: ${idAkunnn}");

                          if (_formKey.currentState!.validate()) {
                            PengajuhanKeluhan.InsertDataKeluhan(
                                    idAkunnn.toString(),
                                    textEditingControllerJudulLaporan!.text,
                                    textEditingControllerIsiLaporan!.text,
                                    randomValueAsalPelapor.toString(),
                                    randomValueKejadianDusun.toString(),
                                    randomValueKategoriLaporan.toString(),
                                    pp.toString(),
                                    fileUp!.text.toString())
                                .then((value) => {
                                      if (value.code == 200)
                                        {
                                          print("jelase kenek"),
                                          if (fileUp!.text.toString() != "")
                                            {
                                              PengajuhanKeluhan
                                                  .uploadFileKeluhan(_file!)
                                            }
                                        }
                                      else
                                        {print("gagal banh")}
                                    });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Ajukan Keluhan",
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

  Widget PilihTanggal(String labelName, String pesanValidasi,
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
            validator: (value) {
              if (value!.isEmpty || value == null) {
                return "${pesanValidasi} Tidak Boleh Kosong";
              }
            },
            controller: text_kontrol,
            readOnly: true,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        text_kontrol.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
                  child: Icon(Icons.calendar_today),
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

  Widget customDropDownKategoriLaporan(
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ListColor.warnaBiruSidoKare)),
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
                randomValueKategoriLaporan = value;
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

  Widget customDropDownLokasiKejadian(
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ListColor.warnaBiruSidoKare)),

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
                randomValueKejadianDusun = value;
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

  Widget customDropDownLokasiAsalPelapor(
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ListColor.warnaBiruSidoKare)),

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
                randomValueAsalPelapor = value;
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
