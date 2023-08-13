import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sidokare_mobile_app/component/LoadingComponent.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/image_class.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';
import 'package:flutter/scheduler.dart';

import '../component/jenis_button.dart';
import '../const/const.dart';
import '../const/list_color.dart';
import '../const/util_pref.dart';
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
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image;
  String? _namaFile;
  ModelAccount? model;

  Future _pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 25);
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
      if (urlGambar == "" || urlGambar == null || urlGambar == "kosong") {
        return AssetImage("assets/accountBlank.png") as ImageProvider;
      } else {
        return NetworkImage(
                "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${urlGambar.replaceAll("'", "")}")
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

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

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
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
    final wokwok = Provider.of<ProviderAccount>(context, listen: false);
    int akunn = wokwok.getIdAkun();
    print("Akun Masuk ${akunn}");
    final DataDiriInit = Provider.of<ProviderAccount>(context, listen: false)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == akunn);
    getNama = TextEditingController(text: DataDiriInit.nama.toString());
    getNik = TextEditingController(text: DataDiriInit.Nik.toString());
    getEmail = TextEditingController(text: DataDiriInit.email.toString());
    getTelp = TextEditingController(text: DataDiriInit.noTelepon.toString());
  }

  bool statusLoadGambar = false;

  Map? getData;
  @override
  Widget build(BuildContext context) {
    // final idAkunnn = ModalRoute.of(context)?.settings.arguments as int;
    getData = ModalRoute.of(context)?.settings.arguments as Map;
    int idAkunnn = getData?['id'];
    String urlGambar = getData?['url_gbr'];
    providerAccount = Provider.of<ProviderAccount>(context);
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == idAkunnn);
    print("awal awal apa gambar ${urlGambar}");
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return statusLoadGambar == true
            ? LoadingComponent(prosesName: "Upload Gambar")
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: ComponentTextTittle("Akun Saya"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text(
                                    'Kamu Yakin akan Keluar dari Aplikasi?'),
                                actions: [
                                  TextButton(
                                    child: Text('Tidak'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Menutup dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Iya'),
                                    onPressed: () {
                                      UtilPref().removeSingleAccount().then(
                                          (value) => {print("Remove Success")});
                                      UtilPref().saveLoginStatus(false);
                                      UtilPref().saveSingleAccount(null);
                                      // Tindakan yang akan dilakukan ketika tombol "OK" ditekan
                                      SystemNavigator.pop();
                                      // Menutup dialog
                                      // Tambahkan kode logika atau tindakan yang ingin Anda lakukan di sini setelah menekan tombol "OK"
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.logout_outlined,
                          color: Colors.redAccent,
                        ))
                  ],
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                body: SafeArea(
                  maintainBottomViewPadding: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
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
                                      child: ChangeProfileBunder(
                                        namaGambar: urlGambar,
                                        lebarFoto: 130,
                                        tinggiFoto: 130,
                                        fileGambar: _image,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 90.w, top: 80.h),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            ListColor.warnaBiruSidoKare,
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              _pickImage(ImageSource.gallery);
                                            },
                                            icon:
                                                Icon(Icons.mode_edit_outline)),
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
                                    urlGambar.toString().replaceAll("'", ""),
                                nama: getNama?.text,
                                nomor: getTelp?.text,
                                nik: getNik?.text,
                                emaill: getEmail?.text,
                                fileBaru: _image),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  late List<ModelAccount> listAcc;
  Widget _Button(
      {String? idakun,
      String? namaGmbrHps,
      String? nama,
      String? nik,
      String? emaill,
      String? nomor,
      File? fileBaru}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("Namanya adalah == ${nama}");
              print("Namanya2 adalah == ${getNama?.text}");
              print("telp2 adalah == ${nomor}");
              print("nama gambar hapus ${namaGmbrHps}");
              print("Telp == adalah ${getTelp?.text}");

              if (_image == null || _namaFile == "") {
                print("Kosong");
                setState(() {
                  statusLoadGambar = true;
                });
                HttpStatefull.UpdateProfileSaja(
                        idAkun: idakun,
                        namaProfile: getNama?.text.toString(),
                        NomorTelp: getTelp?.text.toString())
                    .then((value) => {
                          if (value.code == 200)
                            {
                              print(
                                  "Nama File Update data saja adalah ${_namaFile}"),
                              model = ModelAccount(
                                  id_akun: idakun.toIntOrNull(),
                                  nama: getNama!.text.toString(),
                                  username: "",
                                  email: emaill.toString(),
                                  noTelepon: getTelp!.text.toString(),
                                  password: "",
                                  Nik: nik.toString(),
                                  urlGambar: namaGmbrHps.toString()),
                              UtilPref().saveSingleAccount(null),
                              UtilPref().removeSingleAccount(),
                              UtilPref().saveSingleAccount(model),
                              listAcc = [
                                ModelAccount(
                                    id_akun: idakun.toIntOrNull(),
                                    nama: getNama!.text.toString(),
                                    username: "",
                                    email: emaill.toString(),
                                    noTelepon: getTelp!.text.toString(),
                                    password: "",
                                    Nik: nik.toString(),
                                    urlGambar: namaGmbrHps.toString())
                              ],
                              providerAccount!.setDataDiri(listAcc),
                              providerAccount?.updateData(
                                  0,
                                  idakun.toInt(),
                                  getNama!.text.toString(),
                                  nik.toString(),
                                  _namaFile == "" || _namaFile == null
                                      ? namaGmbrHps.toString()
                                      : _namaFile!.replaceAll("'", ""),
                                  getTelp!.text.toString(),
                                  emaill.toString()),
                              _image == null,
                              _namaFile == null,
                              Navigator.of(context).pushNamed(
                                  HalamanUtama.routeName.toString(),
                                  arguments: idakun.toInt()),

                              // Navigator.pushNamed(context,
                              //     HalamanUtama.routeName.toString(),
                              //     arguments: idakun.toInt())
                              // ToastWidget.ToastSucces(context,
                              //     "Berhasil Update Data", "Selamat"),
                            }
                          else
                            {
                              setState(() {
                                statusLoadGambar = false;
                              })
                            }
                        });
              } else {
                setState(() {
                  statusLoadGambar = true;
                });
                HttpStatefull.sendRequestWithFile(
                        id_akun: idakun,
                        delPic: namaGmbrHps,
                        nama: getNama?.text.toString(),
                        nomorHp: getTelp?.text.toString(),
                        file: fileBaru)
                    .then((value) => {
                          if (value == 200)
                            {
                              print("Nama File adalah ${_namaFile}"),
                              providerAccount?.updateData(
                                  0,
                                  idakun.toInt(),
                                  getNama!.text.toString(),
                                  nik.toString(),
                                  _namaFile!.replaceAll("'", ""),
                                  getTelp!.text.toString(),
                                  emaill.toString()),
                              model = ModelAccount(
                                  id_akun: idakun.toIntOrNull(),
                                  nama: getNama!.text.toString(),
                                  username: "",
                                  email: emaill.toString(),
                                  noTelepon: getTelp!.text.toString(),
                                  password: "",
                                  Nik: nik.toString(),
                                  urlGambar:
                                      _namaFile.toString().replaceAll("'", "")),
                              UtilPref().saveSingleAccount(null),
                              UtilPref().removeSingleAccount(),
                              UtilPref().saveSingleAccount(model),
                              listAcc = [
                                ModelAccount(
                                    id_akun: idakun.toIntOrNull(),
                                    nama: getNama!.text.toString(),
                                    username: "",
                                    email: emaill.toString(),
                                    noTelepon: getTelp!.text.toString(),
                                    password: "",
                                    Nik: nik.toString(),
                                    urlGambar: _namaFile
                                        .toString()
                                        .replaceAll("'", ""))
                              ],
                              providerAccount!.setDataDiri(listAcc),

                              _image == null,
                              // _namaFile == null,
                              Navigator.pushNamed(
                                  context, HalamanUtama.routeName.toString(),
                                  arguments: idakun.toInt()),
                              ToastWidget.ToastSucces(
                                  context, "Berhasil Update Data", "Selamat"),
                            }
                          else
                            {
                              setState(() {
                                statusLoadGambar = false;
                              })
                            },
                        });
              }
            },
            style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
            child: ComponentTextButton("Edit Akun"),
          ),
          // ButtonSelesai("Keluar"),
        ],
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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Kamu Yakin akan Keluar dari Aplikasi?'),
                actions: [
                  TextButton(
                    child: Text('Tidak'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Menutup dialog
                    },
                  ),
                  TextButton(
                    child: Text('Iya'),
                    onPressed: () {
                      UtilPref()
                          .removeSingleAccount()
                          .then((value) => {print("Remove Success")});
                      UtilPref().saveLoginStatus(false);
                      UtilPref().saveSingleAccount(null);
                      // Tindakan yang akan dilakukan ketika tombol "OK" ditekan
                      SystemNavigator.pop();
                      // Menutup dialog
                      // Tambahkan kode logika atau tindakan yang ingin Anda lakukan di sini setelah menekan tombol "OK"
                    },
                  ),
                ],
              );
            },
          );
        },
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(55.h),
            backgroundColor: Colors.redAccent),
      ),
    );
  }
}
