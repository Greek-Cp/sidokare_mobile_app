import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/font_type.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class DetailPengajuanPPID extends StatefulWidget {
  static String? routeName = "/DetailPengajuanPPID";

  @override
  State<DetailPengajuanPPID> createState() => _DetailPengajuanPPIDState();
}

class _DetailPengajuanPPIDState extends State<DetailPengajuanPPID> {
  @override
  Widget build(BuildContext context) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription("Nama Lengkap"),
                            ComponentTextDescription("Nik"),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription(
                                ": Daffa Aditya Rejasa R.R."),
                            ComponentTextDescription(": 3512312321313213"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ComponentTextDescription("Judul Laporan"),
                    ComponentTittleCustom(
                      "KEHAMILAN MASSAL DI DESA SIDOKARE",
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
                        child: ComponentTextDescription(
                          """ Para ibu-ibu muda Desa Sidokare telah menciptkan resep makan tradisional untuk merayakan lomba Momen peringatan Hari Kemerdekaan RI sering dimeriahkan dengan beragam lomba, mulai dari tingkat RT/RW sampai di sekolah dan kantor. Tujuan lomba ini biasanya menguji kekompakan warga. 
                
                Jika Anda menjadi panitia dan masih bingung ingin mengadakan apa, simak 20 ide lomba 17 Agustus yang seru dan menarik berikut ini.
                    """,
                          teksColor: Colors.grey,
                          textAlign: TextAlign.start,
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
                            ComponentTextDescription("Kategori PPID"),
                            ComponentTextDescription("Upload File Pendukung"),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ComponentTextDescription(": Desa Sidokare"),
                            ComponentTextDescription(": Perorangan"),
                            ComponentTextDescription(": Sampah.pdf"),
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
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Color.fromARGB(255, 130, 225, 197),
                      child: Padding(
                        padding: EdgeInsets.all(20.0.w),
                        child: Row(children: [
                          Icon(
                            Icons.file_copy,
                            color: Colors.white,
                          ),
                          ComponentTextButton("PPID_21334.pdf")
                        ]),
                      ),
                    ),
                    ComponentTextDescriptionBawah(
                        "Silakan Download file , file akan tersimpan dalam device pada folder download"),
                    SizedBox(
                      height: 30.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.grey,
                    ),
                    ButtonKeberatan("Keberatan"),
                    ButtonSelesai("Selesai")
                  ]),
            ),
          ),
        );
      },
    );
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
  ButtonSelesai(this.buttonName);
  @override
  Widget build(BuildContext context) {
    return _Button(context, buttonName);
  }

  Widget _Button(BuildContext context, String? buttonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ElevatedButton(
        onPressed: () {},
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
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
