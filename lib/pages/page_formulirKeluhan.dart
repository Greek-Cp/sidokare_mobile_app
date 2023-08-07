import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/LoadingComponent.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_keluhan.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';
import 'package:intl/intl.dart';

import '../provider/provider_account.dart';

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
  TextEditingController? getMap = TextEditingController();
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
    'Lingkungan',
    'Kewarganegaraan',
    'Topik lainnya'
  ];

  bool statusPengajuan = false;

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
  static String? randomValueKategoriLaporan = "Lingkungan";
  static String? randomValueKejadianDusun = "Kewarganegaraan";
  static String? randomValueAsalPelapor = "Topik lainnya";
  static String? randomValueRT = "001";
  static String? randomValueRW = "001";

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
      textEditingControllerAsalPelapor!.text = "Desa Sidokare";
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return statusPengajuan == true
            ? LoadingComponent(
                prosesName: "Keluhan",
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    "Formulir Pengajuan Keluhan",
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
                                text_kontrol: textEditingControllerJudulLaporan,
                                hintText: "Masukkan Judul Keluhan",
                                labelName: "Judul Keluhan",
                                pesanValidasi: "Judul Laporan")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextFormMultiLine(
                                text_kontrol: textEditingControllerIsiLaporan,
                                hintText: "Masukkan Isi Keluhan",
                                labelName: "Isi Keluhan",
                                pesanValidasi: "Isi Keluhan")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextForm(
                                readyOnlyTydack: true,
                                text_kontrol: textEditingControllerAsalPelapor,
                                hintText: "Masukkan Alamat",
                                labelName: "Asal Pelapor",
                                pesanValidasi: "Asal Pelapor")),
                      ),
                      DropdownRTRW(
                          listItemRT: RT,
                          listItemRW: RW,
                          namaLabelRT: "RT",
                          namaLabelRW: "RW",
                          hintTextRT: "Pilih RT",
                          hintTextRW: "Pilih RW",
                          randomlabelRT: randomValueRT,
                          randomlabelRW: randomValueRT,
                          errorKosong: "harap pilih"),
                      GetLokasiNow(
                          labelName: "Lokasi Kejadian",
                          hintText: "Masukkan Alamat",
                          pesanValidasi: "Harap Isi",
                          text_kontrol: getMap),
                      // customDropDownLokasiKejadian(
                      //     listItem: listDusun,
                      //     namaLabel: "Lokasi Kejadian",
                      //     hintText: "Pilih Dusun",
                      //     errorKosong: "Kejadian",
                      //     randomlabel: randomValueKejadianDusun),
                      customDropDownKategoriLaporan(
                        listItem: listKategoriLaporan,
                        namaLabel: "Kategori Laporan",
                        hintText: "Pilih Kategori",
                        errorKosong: "Laporan",
                        randomlabel: randomValueKategoriLaporan,
                      ),
                      PilihTanggal("Tanggal Kejadian", "Kejadian",
                          controllerDate!, "Masukkan Tanggal"),
                      UpfilePendukung("Upload File Pendukung (max: 2Mb)",
                          "gatau", fileUp!, "Silakan Upload File"),
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
                                  "RT/RW == ${randomValueRT} / ${randomValueRW}");
                              print(
                                  "judul Laporan : ${textEditingControllerJudulLaporan!.text}");
                              print(
                                  "isi Laporan : ${textEditingControllerIsiLaporan!.text}");
                              print(
                                  "Kategori Laporan : ${randomValueKategoriLaporan.toString()}");
                              print("ID AKUN :: ${idAkunnn}");
                              print("Lokasi kejadian == ${getMap!.text}");
                              print(
                                  "Asal Pelapor == ${textEditingControllerAsalPelapor!.text}");
                              if (_formKey.currentState!.validate()) {
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
                                  PengajuhanKeluhan.InsertDataKeluhan(
                                          idAkunnn.toString(),
                                          textEditingControllerJudulLaporan!
                                              .text,
                                          textEditingControllerIsiLaporan!.text,
                                          textEditingControllerAsalPelapor!
                                              .text, //Asal
                                          getMap!.text, // Lokasi Kejadian
                                          randomValueKategoriLaporan.toString(),
                                          pp.toString(),
                                          randomValueRT.toString(),
                                          randomValueRW.toString(),
                                          fileUp!.text.toString())
                                      .then((value) => {
                                            if (value.code == 200)
                                              {
                                                print("jelase kenek"),
                                                if (fileUp!.text.toString() !=
                                                    "")
                                                  {
                                                    PengajuhanKeluhan
                                                            .uploadFileKeluhan(
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
                                                            })
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
                                                  }
                                              }
                                            else
                                              {print("gagal banh")}
                                          });
                                }
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
                    ],
                  ),
                ),
              );
      },
    );
  }

  // void getAddressFromCoordinates(double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await Geolocator.reverseGeocode(latitude, longitude);
  //   Placemark place = placemarks[0];
  //   print('Address: ${place.street}, ${place.locality}, ${place.country}');
  // }
  bool lokasi = false;
  void getCurrentLocation() async {
    setState(() {
      lokasi = true;
      EasyLoading.show(
          status: "Mencari Lokasi....", maskType: EasyLoadingMaskType.black);
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
    String ppp =
        await getAddressFromCoordinates(position.latitude, position.longitude);
    getMap!.text = ppp;
    setState(() {
      lokasi = false;
      EasyLoading.dismiss();
    });
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = place.street ?? '';
        String locality = place.locality ?? '';
        String country = place.country ?? '';
        return "${address}, ${locality}, ${country}";
        // print('Address: $address, $locality, $country');
      } else {
        print('No address found');
        return "eror";
      }
    } catch (e) {
      print('Error: $e');
      return "Eror : ${e}";
    }
  }

  Widget GetLokasiNow(
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
            validator: (value) {
              if (value!.isEmpty || value == null) {
                return "${pesanValidasi} Tidak Boleh Kosong";
              }
            },
            controller: text_kontrol,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () async {
                    // _pickFile();
                    if (Platform.isAndroid) {
                      getCurrentLocation();
                    } else {
                      ToastWidget.ToastInfo(context,
                          "Hanya dapat dilakukan pada Android", "Mohon Maaf");
                    }

                    print("halooo cantikk");
                  },
                  child: Icon(Icons.map_sharp),
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
