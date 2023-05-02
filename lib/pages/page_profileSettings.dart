import 'dart:io';
import 'dart:math';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';

import '../const/const.dart';
import '../const/list_color.dart';
import '../provider/provider_account.dart';

class PageProfileUser extends StatefulWidget {
  static String? routeName = "/profilePic";
  @override
  State<PageProfileUser> createState() => _PageProfileUserState();
}

class _PageProfileUserState extends State<PageProfileUser> {
  static String? Inisialnama;
  static String? Inisialnik;
  static String? Inisialemail;
  static String? Inisialtelp;
  TextEditingController? getNama;
  TextEditingController? getNik;
  TextEditingController? getEmail;
  TextEditingController? getTelp;
  ProviderAccount? providerAccount;

  File? _image;
  String? _namaFile;
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        // Random random = Random();
        // String namaFileBaru = "profile${random.nextInt(1000)}";
        // String pathBaru =
        //     Path.join(Path.dirname(_image.toString()), namaFileBaru);
        _namaFile = Path.basename(_image.toString());
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print("eror gambar :: ${e}");
      // Navigator.of(context).pop();
    }
  }

  ImageProvider ChangeProfile({String? urlGambar, File? gambar}) {
    if (gambar == null) {
      if (urlGambar == "" || urlGambar == null) {
        return AssetImage("assets/accountBlank.png") as ImageProvider;
      } else {
        return NetworkImage(
                "http://${ApiPoint.BASE_URL}/storage/profile/${urlGambar.replaceAll("'", "")}")
            as ImageProvider;
      }
    } else {
      return FileImage(gambar) as ImageProvider;
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      final wokwok = Provider.of<ProviderAccount>(context, listen: false);
      int akunn = wokwok.getIdAkun;
      print("Akun Masuk ${akunn}");
      final DataDiriInit = Provider.of<ProviderAccount>(context, listen: false)
          .GetDataDiri
          .firstWhere((idData) => idData.id_akun == akunn);

      getNama = TextEditingController(text: DataDiriInit.nama.toString());
      getNik = TextEditingController(text: DataDiriInit.Nik.toString());
      getEmail = TextEditingController(text: DataDiriInit.email.toString());
      getTelp = TextEditingController(text: DataDiriInit.noTelepon.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final idAkunnn = ModalRoute.of(context)?.settings.arguments as int;

    providerAccount = Provider.of<ProviderAccount>(context);

    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == idAkunnn);
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    ComponentTextTittle("Akun Saya"),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                              width: 130.w,
                              height: 130.h,
                              child: CircleAvatar(
                                backgroundImage: ChangeProfile(
                                    urlGambar: DataDiri.urlGambar.toString(),
                                    gambar: _image),
                                backgroundColor: Colors.amberAccent,
                                // maxRadius: 70,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 90.w, top: 80.h),
                              child: CircleAvatar(
                                backgroundColor: ListColor.warnaBiruSidoKare,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    icon: Icon(Icons.mode_edit_outline)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextFieldImport.TextFormNama(
                        labelName: "Nama",
                        text_kontrol: getNama,
                        pesanValidasi: "Nama"),
                    TextFieldImport.TextForm(
                        labelName: "NIK",
                        readyOnlyTydack: true,
                        text_kontrol: getNik,
                        pesanValidasi: "NIk"),
                    TextFieldImport.TextForm(
                        labelName: "Email",
                        readyOnlyTydack: true,
                        text_kontrol: getEmail,
                        pesanValidasi: "Telepon"),
                    TextFieldImport.TextFormTelp(
                        labelName: "Nomor Telepon",
                        text_kontrol: getTelp,
                        length: 12,
                        pesanValidasi: "Telepon"),
                    _Button(
                        idakun: DataDiri.id_akun.toString(),
                        namaGmbrHps:
                            DataDiri.urlGambar.toString().replaceAll("'", ""),
                        nama: getNama?.text,
                        nomor: getTelp?.text,
                        nik: getNik?.text,
                        emaill: getEmail?.text,
                        fileBaru: _image)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _Button(
      {String? idakun,
      String? namaGmbrHps,
      String? nama,
      String? nik,
      String? emaill,
      String? nomor,
      File? fileBaru}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Consumer<ProviderAccount>(
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: () {
              print("Namanya adalah == ${nama}");
              print("Namanya2 adalah == ${getNama?.text}");
              print("telp2 adalah == ${nomor}");
              print("Telp == adalah ${getTelp?.text}");
              if (_image == null || _namaFile == "") {
                print("Kosong");
                HttpStatefull.UpdateProfileSaja(
                        idAkun: idakun,
                        namaProfile: getNama?.text.toString(),
                        NomorTelp: getTelp?.text.toString())
                    .then((value) => {
                          if (value.code == 200)
                            {
                              print(
                                  "Nama File Update data saja adalah ${_namaFile}"),
                              providerAccount?.updateData(
                                  0,
                                  idakun.toInt(),
                                  getNama!.text.toString(),
                                  nik.toString(),
                                  _namaFile == "" || _namaFile == null
                                      ? namaGmbrHps.toString()
                                      : _namaFile!,
                                  getTelp!.text.toString(),
                                  emaill.toString()),
                              _image == null,
                              _namaFile == null,
                              Navigator.pushNamed(
                                  context, HalamanUtama.routeName.toString(),
                                  arguments: idakun.toInt()),
                              ToastWidget.ToastSucces(
                                  context, "Berhasil Update Data"),
                            }
                        });
              } else {
                HttpStatefull.sendRequestWithFile(
                        id_akun: idakun,
                        delPic: namaGmbrHps,
                        nama: getNama?.text.toString(),
                        nomorHp: getTelp?.text.toString(),
                        file: fileBaru)
                    .then((value) => {
                          print("Nama File adalah ${_namaFile}"),
                          providerAccount?.updateData(
                              0,
                              idakun.toInt(),
                              getNama!.text.toString(),
                              nik.toString(),
                              _namaFile!,
                              getTelp!.text.toString(),
                              emaill.toString()),
                          _image == null,
                          _namaFile == null,
                          Navigator.pushNamed(
                              context, HalamanUtama.routeName.toString(),
                              arguments: idakun.toInt()),
                          ToastWidget.ToastSucces(
                              context, "Berhasil Update Data"),
                        });
              }
            },
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
            child: Text(
              "Edit Akun ",
              style: TextStyle(fontSize: size.textButton.sp),
            ),
          );
        },
      ),
    );
  }
}