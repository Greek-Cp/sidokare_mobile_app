import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/LoadingComponent.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/response/keberatan.dart';
import 'package:sidokare_mobile_app/model/response/pengajuan_keluhan.dart';
import 'package:sidokare_mobile_app/pages/page_BerhasilBuatLaporan.dart';

import '../component/text_field.dart';
import '../const/list_color.dart';
import 'package:intl/intl.dart';

import '../provider/provider_account.dart';

class PageFormulirKeberatanPPID extends StatefulWidget {
  static String routeName = "/formulir_pengajuanKeberatan";

  @override
  State<PageFormulirKeberatanPPID> createState() =>
      _PageFormulirKeberatanPPIDState();
}

class _PageFormulirKeberatanPPIDState extends State<PageFormulirKeberatanPPID> {
  TextEditingController? textEditingControllerNamaLengkap =
      TextEditingController();
  TextEditingController? textEditingControllerNIK = TextEditingController();
  TextEditingController? getAlamat = TextEditingController();
  TextEditingController? getCatatan = TextEditingController();

  DateTime selectedDate = DateTime.now();
  File? _file;

  @override
  void initState() {
    super.initState();
    // selectedDate = DateTime.now();
  }

  bool statusPengajuan = false;

  final List<String> listDusun = ['Sidokare', 'SidoMaju', 'SidoSido'];
  final List<String> listKategoriPenolakan = [
    'Permohonan informasi ditolak',
    'Informasi berkala tidak disediakan',
    'Permintaan informasi tidak ditanggapi ',
    'Permintaan informasi ditanggapi tidak sebagaimana yang diminta ',
    'Permintaan informasi tidak dipenuhi ',
    'Biaya yang dikenakan tidak wajar ',
    'Informasi disampaikan melebihi jangka waktu yang ditentukan',
  ];
  static String? randomValueKategoriPenolakan = "Permohonan informasi ditolak";

  String? selectedRt = 'RT 01';
  String? selectedRw = 'RW 01';

  List<String> rtList = [
    'RT 01',
    'RT 02',
    'RT 03',
    // Tambahkan RT lainnya di sini sesuai kebutuhan
  ];

  List<String> rwList = [
    'RW 01',
    'RW 02',
    'RW 03',
    // Tambahkan RW lainnya di sini sesuai kebutuhan
  ];
  final _formKey = GlobalKey<FormState>();
  Map? getDataFromDetail;
  @override
  Widget build(BuildContext context) {
    // final idAkunnn = ModalRoute.of(context)?.settings.arguments as int;
    getDataFromDetail = ModalRoute.of(context)?.settings.arguments as Map;
    int akunDek = getDataFromDetail?['id_akun'];
    String id = getDataFromDetail?['id'];
    String kategori = getDataFromDetail?['kategori'];
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == akunDek.toInt());

    setState(() {
      textEditingControllerNIK!.text = DataDiri.Nik.toString();
      textEditingControllerNamaLengkap!.text = DataDiri.nama.toString();
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return statusPengajuan == true
            ? LoadingComponent(
                prosesName: "Keberatan",
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    "HalamaN keberatan",
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
                      SizedBox(
                        height: 20,
                      ),
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
                      GetLokasiNow(
                          labelName: "Alamat",
                          pesanValidasi: "Alamat",
                          text_kontrol: getAlamat,
                          hintText: "Masukkan Alamat"),
                      customDropDownLokasiAsalPelapor(
                          listItem: listKategoriPenolakan,
                          namaLabel: "Asal Keberatan",
                          hintText: "pilih kategori",
                          errorKosong: "keberatan",
                          randomlabel: randomValueKategoriPenolakan),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            child: TextFieldImport.TextFormMultiLine(
                                text_kontrol: getCatatan,
                                hintText: "Catatan Tambahan",
                                labelName: "Catatan Tambahan",
                                pesanValidasi: "Isi Laporan")),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                minimumSize: Size.fromHeight(55.h)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("ID Kategori From Detail == ${id}");
                                print("jneis layanan ${kategori}");
                                print("ID akun == ${akunDek}");
                                print(
                                    "Alamat User adalah == ${getAlamat!.text}");
                                print(
                                    "Catatan Tambahan == ${getCatatan!.text}");
                                if (kategori == "ppid") {
                                  KeberatanStatus.InsertKeberatanPPID(
                                          id_akun: akunDek.toString(),
                                          alamat: getAlamat!.text,
                                          catatan: getCatatan!.text,
                                          alasan: randomValueKategoriPenolakan
                                              .toString(),
                                          idppid: id.toString())
                                      .then((value) => {
                                            setState(() {
                                              statusPengajuan = true;
                                            }),
                                            if (value.code == "200")
                                              {
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    BerhasilBuatLaporan
                                                        .routeName
                                                        .toString(),
                                                    arguments:
                                                        akunDek.toString()),
                                                ToastWidget.ToastSucces(
                                                    context,
                                                    "Berhasil Mengajukan Keberatan PPID",
                                                    "Selamatt")
                                              }
                                            else
                                              {print("kok sini")}
                                          });
                                } else if (kategori == "aspirasi") {
                                  print("halo dek");
                                  KeberatanStatus.InsertKeberatanAspirasi(
                                          id_akun: akunDek.toString(),
                                          alamat: getAlamat!.text,
                                          catatan: getCatatan!.text,
                                          alasan: randomValueKategoriPenolakan
                                              .toString(),
                                          id_aspirasi: id.toString())
                                      .then((value) => {
                                            setState(() {
                                              statusPengajuan = true;
                                            }),
                                            if (value.code == "200")
                                              {
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    BerhasilBuatLaporan
                                                        .routeName
                                                        .toString(),
                                                    arguments:
                                                        akunDek.toString()),
                                                ToastWidget.ToastSucces(
                                                    context,
                                                    "Berhasil Mengajukan Keberatan Aspirasi",
                                                    "Selamatt")
                                              }
                                            else
                                              {print("kok sini")}
                                          });
                                } else {
                                  print("Keluhan Disini");
                                  KeberatanStatus.InsertKeberatanKeluhan(
                                          id_akun: akunDek.toString(),
                                          alamat: getAlamat!.text,
                                          catatan: getCatatan!.text,
                                          alasan: randomValueKategoriPenolakan
                                              .toString(),
                                          id_keluhan: id.toString())
                                      .then((value) => {
                                            setState(() {
                                              statusPengajuan = true;
                                            }),
                                            if (value.code == "200")
                                              {
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    BerhasilBuatLaporan
                                                        .routeName
                                                        .toString(),
                                                    arguments:
                                                        akunDek.toString()),
                                                ToastWidget.ToastSucces(
                                                    context,
                                                    "Berhasil Mengajukan Keberatan Keluhan",
                                                    "Selamatt")
                                              }
                                            else
                                              {print("kok sini")}
                                          });
                                }
                              }

                              // print(
                              //     "Asal Laporan : ${randomValueAsalPelapor.toString()}");
                              // print("Dusun : ${randomValueKejadianDusun.toString()}");
                              // print(
                              //     "Kategori Laporan : ${randomValueKategoriLaporan.toString()}");
                              // print("ID AKUN :: ${54}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Ajukan Keberatan",
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

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
    String ppp =
        await getAddressFromCoordinates(position.latitude, position.longitude);
    getAlamat!.text = ppp;
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
                    print("halooo cantikk");
                    if (Platform.isAndroid) {
                      getCurrentLocation();
                    } else {
                      ToastWidget.ToastInfo(
                          context, "Hanya bisa pada Android", "Mohon Maaf");
                    }
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
                randomValueKategoriPenolakan = value;
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
