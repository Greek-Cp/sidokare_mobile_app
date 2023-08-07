import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/LoadingComponent.dart';

import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';

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
  TextEditingController? textEditingControllerNomorTelepon =
      TextEditingController();
  TextEditingController? textEditingControllerEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static File? _file;
  final List<String> listDusun = ['Sidokare', 'SidoMaju', 'SidoSido'];
  final List<String> listPPID = ['Perorangan', 'Badan Hukum', 'Badan Usaha'];
  final List<String> RT = [
    '001',
    '002',
    '003',
    '004',
    '005',
    '006',
    '007',
    '008'
  ];
  final List<String> RW = [
    '001',
    '002',
    '003',
    '004',
    '005',
    '006',
    '007',
    '008'
  ];
  static String? randomValuePPID;
  static String? randomValueDusun = "Sidokare";
  static String? randomValueRT = "001";
  static String? randomValueRW = "001";

  bool isVisibleText = false;
  bool statusPengajuan = false;

  static String boolq = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("apa awal nyaa :: ${randomValuePPID}");
  }

  String textBeritahu({String? cocokne}) {
    if (cocokne == "Perorangan") {
      print("tes 1");
      return "Wajib Upload KTP";
    } else if (cocokne == "Badan Hukum") {
      print("tes 2");
      return "Wajib Upload Surat Pendirian Badan Hukum";
    } else {
      print("tes 3");
      return "Wajib Upload Surat Pendirian Badan Usaha";
    }
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
      textEditingControllerAsalPelapor!.text = "Desa Sidokare";
      // textBeritahu();
      // randomValuePPID;
      // print("random ${randomValuePPID}");
    });

    String sttss({String? stss}) {
      if (stss == "Perorangan") {
        return "Upload KTP";
      } else if (stss == "Badan Hukum") {
        return "Upload surat Pendirian Badan hukum";
      } else {
        return "Upload Surat Pendirian Badan Usaha";
      }
    }

    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return statusPengajuan == true
            ? LoadingComponent(
                prosesName: "PPID",
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    "Formulir Pengajuan PPID",
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFieldImport.TextFormTelp(
                            labelName: "Nomor Telepon",
                            length: 12,
                            text_kontrol: textEditingControllerNomorTelepon,
                            hintText: "Masukkan Nomor Telepon",
                            pesanValidasi: "Nomor Telepon"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFieldImport.TextFormEmail(
                            labelName: "Email",
                            text_kontrol: textEditingControllerEmail,
                            hintText: "Masukkan Email",
                            pesanValidasi: "Email"),
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
                            child: TextFieldImport.TextFormMultiLine(
                                text_kontrol: textEditingControllerIsiLaporan,
                                hintText: "Masukkan Isi Laporan",
                                labelName: "Isi Laporan",
                                pesanValidasi: "Isi Laporan")),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFieldImport.TextForm(
                            readyOnlyTydack: true,
                            text_kontrol: textEditingControllerAsalPelapor,
                            labelName: "Alamat",
                            pesanValidasi: "Alamat"),
                      ),
                      DropdownRTRW(
                          listItemRT: RT,
                          listItemRW: RW,
                          namaLabelRT: "RT",
                          namaLabelRW: "RW",
                          hintTextRT: "Pilih RT",
                          hintTextRW: "Pilih RW",
                          errorKosong: "RT / RW",
                          randomlabelRT: randomValueRT,
                          randomlabelRW: randomValueRW),
                      customDropDownPPID(
                        listItem: listPPID,
                        namaLabel: "Kategori PPID",
                        hintText: randomValuePPID,
                        errorKosong: "PPID",
                      ),
                      UpfilePendukung(
                          "Upload File Pendukung (max: 2Mb)",
                          "file",
                          fileUp!,
                          sttss(stss: randomValuePPID.toString())),
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
                              print("Jenis PPID == ${randomValuePPID}");
                              print("Dusun Terpilih == ${randomValueDusun}");
                              print("IdAkunnyaa == ${idAkunnn.toString()}");
                              print(
                                  "nama == ${textEditingControllerNamaLengkap!.text}");
                              print(
                                  "Telp ${textEditingControllerNomorTelepon!.text}");
                              print(
                                  "email == ${textEditingControllerEmail!.text}");
                              print("RT == ${randomValueRT}");
                              print("RW == ${randomValueRW}");

                              if (_formKey.currentState!.validate()) {
                                print("Tes file :: " + fileUp!.text.toString());
                                int sizeInBytes = _file!.lengthSync();
                                double sizeInMb = sizeInBytes / (1024 * 1024);
                                if (sizeInMb > 2) {
                                  ToastWidget.ToastInfo(
                                      context,
                                      "Maksimal file yang dapat upload 2MB",
                                      "File Terlalu Besar");
                                } else {
                                  setState(() {
                                    statusPengajuan = true;
                                  });
                                  PengajuanPPID.InsertDataPPID(
                                          idAkun: idAkunnn.toString(),
                                          nama_pelapor:
                                              textEditingControllerNamaLengkap!
                                                  .text,
                                          noTelp:
                                              textEditingControllerNomorTelepon!
                                                  .text
                                                  .toString(),
                                          emailUser: textEditingControllerEmail!
                                              .text
                                              .toString(),
                                          JudulLaporan:
                                              textEditingControllerJudulLaporan!
                                                  .text,
                                          isiLaporan:
                                              textEditingControllerIsiLaporan!
                                                  .text,
                                          asalLaporan: "Sidokare",
                                          tujuan:
                                              "pokok kenek ndisek lah masbro",
                                          RT: randomValueRT.toString(),
                                          RW: randomValueRW.toString(),
                                          kategoriPPID:
                                              randomValuePPID.toString(),
                                          File: fileUp!.text.toString())
                                      .then((value) => {
                                            setState(() {
                                              statusPengajuan = true;
                                            }),
                                            if (value.code == 200)
                                              {
                                                print("Kenek paleng"),
                                                if (fileUp!.text.toString() !=
                                                    "")
                                                  {
                                                    PengajuanPPID
                                                            .uploadFilePPID(
                                                                _file!)
                                                        .then((value) => {
                                                              Navigator.popAndPushNamed(
                                                                  context,
                                                                  BerhasilBuatLaporan
                                                                      .routeName
                                                                      .toString(),
                                                                  arguments:
                                                                      idAkunnn
                                                                          .toString())
                                                            }),
                                                  }
                                                else
                                                  {
                                                    Navigator.popAndPushNamed(
                                                        context,
                                                        BerhasilBuatLaporan
                                                            .routeName
                                                            .toString(),
                                                        arguments:
                                                            idAkunnn.toString())
                                                  },
                                              }
                                            else
                                              {print("yahaha gagal")}
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
                                "Ajukan PPID",
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

  Widget DropdownRTRW(
      {List<String>? listItemRT,
      List<String>? listItemRW,
      String? namaLabelRT,
      String? namaLabelRW,
      String? hintTextRT,
      String? hintTextRW,
      String? randomlabelRT,
      String? randomlabelRW,
      String? errorKosong}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "$namaLabelRT",
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 13.sp)),
                    textAlign: TextAlign.start,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 1.0.h, top: 1.0.h, right: 5.0.w),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ListColor.warnaBiruSidoKare)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: Text(
                      '$hintTextRT',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    items: listItemRT
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
                        randomValueRT = value;
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
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "$namaLabelRW",
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 13.sp)),
                    textAlign: TextAlign.start,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          bottom: 1.0.h, top: 1.0.h, right: 5.0.w),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ListColor.warnaBiruSidoKare)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: Text(
                      '$hintTextRW',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    items: listItemRW
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
                        randomValueRW = value;
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
            ),
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
                randomValuePPID = value;
                print("banhhhhh ${value}");
                print("${randomValuePPID} cynnaaa");
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
