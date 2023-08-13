import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/const/util_pref.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';
import 'package:sidokare_mobile_app/pages/page_lupasandi.dart';
import 'package:sidokare_mobile_app/pages/page_register.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

class PageLogin extends StatefulWidget {
  static String? routeName = "/login";

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
  }

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

  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _isHovering = false;
  ProviderAccount? providerAccount;
  @override
  Widget build(BuildContext context) {
    providerAccount = Provider.of<ProviderAccount>(context);

    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return WillPopScope(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              // resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                reverse: true,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(
                            "Selamat Datang",
                            style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.HeaderText.sp)),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Silahkan masuk dan lakukan aktivitas",
                            style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                              fontSize: size.SubHeader.sp,
                              color: ListColor.warnaDescription,
                            )),
                            textAlign: TextAlign.center,
                          ),
                          Lottie.asset(
                            "assets/login_animasi.json",
                            width: 120.w,
                            height: 300.h,
                          ),
                          SizedBox(
                              child: TextFieldImport.TextForm(
                                  labelName: "Email",
                                  text_kontrol: textEditingControllerEmail,
                                  hintText: "Masukkan Emailmu",
                                  pesanValidasi: "Email")),
                          // SizedBox(
                          //     child: TextFieldPassword(
                          //         textEditingControllerPassword,
                          //         "Masukkan Sandi",
                          //         false,
                          //         "Kata Sandi",
                          //         "Kata Sandi")),
                          PasswordDone(
                              hintText: "Masukkan Sandi",
                              text_kontrol: textEditingControllerPassword,
                              labelName: "Kata Sandi",
                              passwordType: _obsecureText,
                              pesanValidasi: "Kata Sandi"),
                          SizedBox(
                            height: 10.sp,
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(
                                  context, LupaSandi.routeName.toString())
                            },
                            child: MouseRegion(
                              onHover: (event) {
                                setState(() {
                                  _isHovering = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  _isHovering = false;
                                });
                              },
                              child: Text(
                                "Lupa Sandi?",
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: _isHovering
                                            ? ListColor.warnaBiruSidoKare
                                            : Colors.grey.shade700,
                                        fontStyle: FontStyle.italic,
                                        fontSize: size.sizeDescriptionPas.sp)),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ListColor.warnaBiruSidoKare,
                                  minimumSize: Size.fromHeight(55.h)),
                              onPressed: () => {
                                    if (_formKey.currentState!.validate())
                                      {
                                        HttpStatefull.loginAkun(
                                                textEditingControllerEmail.text,
                                                textEditingControllerPassword
                                                    .text)
                                            .then((value) async => {
                                                  if (value.code == 200)
                                                    {
                                                      print(
                                                          "Nama anda adalah ${value.nama_lengkap}"),
                                                      print(
                                                          "ID Akun adalah ${value.id_akun}"),
                                                      print(
                                                          "Nik Akun adalah ${value.nik}"),
                                                      print(
                                                          "mamagambar Akun adalah ${value.namaProfile}"),
                                                      providerAccount!.AddData(
                                                          value.id_akun!,
                                                          value.nama_lengkap!,
                                                          value.nik!,
                                                          value.namaProfile!,
                                                          value.nomor_telepon!,
                                                          value.email!),
                                                      providerAccount!
                                                          .setIdAkun(value
                                                              .id_akun!
                                                              .toInt()),
                                                      Navigator.pushNamed(
                                                          context,
                                                          HalamanUtama.routeName
                                                              .toString(),
                                                          arguments:
                                                              value.id_akun),
                                                      FocusManager.instance
                                                          .primaryFocus!
                                                          .unfocus(),
                                                      ToastWidget.ToastSucces(
                                                          context,
                                                          "Masuk Berhasil , Akun Ditemukan",
                                                          "Selamat "),
                                                      UtilPref().saveSingleAccount(
                                                          ModelAccount(
                                                              id_akun:
                                                                  value.id_akun,
                                                              nama: value
                                                                  .nama_lengkap,
                                                              Nik: value.nik,
                                                              urlGambar: value
                                                                  .namaProfile,
                                                              noTelepon: value
                                                                  .nomor_telepon,
                                                              email:
                                                                  value.email)),
                                                      UtilPref()
                                                          .saveLoginStatus(true)
                                                    }
                                                  else if (value.code == 400)
                                                    {
                                                      print(
                                                          "apakag eror kesini"),
                                                      ToastWidget.ToastEror(
                                                          context,
                                                          "Masuk Gagal , Akun Tidak Ditemukan",
                                                          "Mohon Maaf")
                                                    }
                                                })
                                      }
                                    else
                                      {}
                                  },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Masuk",
                                  style:
                                      TextStyle(fontSize: size.textButton.sp),
                                ),
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Belum punya akun? ",
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: size.sizeDescriptionPas.sp)),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.pushNamed(context,
                                      PageRegister.routeName.toString()),
                                  FocusManager.instance.primaryFocus!.unfocus(),
                                },
                                child: Text(
                                  "Daftar Disini",
                                  style: TextStyle(
                                      fontFamily: fontfix.DmSansBruh,
                                      color: ListColor.warnaBiruSidoKare,
                                      fontSize: size.sizeDescriptionPas.sp),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onWillPop: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Konfirmasi'),
                    content: Text('Yakin ingin keluar dari aplikasi?'),
                    actions: [
                      TextButton(
                        child: Text('tidak'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog
                        },
                      ),
                      TextButton(
                        child: Text('Iya'),
                        onPressed: () {
                          SystemNavigator.pop(); // Keluar dari aplikasi
                        },
                      ),
                    ],
                  );
                },
              );
              return false;
            });
      },
    );
  }

  bool _obsecureText = false;

  void _getVisibility() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Widget PasswordDone(
      {TextEditingController? text_kontrol,
      String? hintText,
      bool? passwordType,
      String? labelName,
      String? pesanValidasi}) {
    return Column(
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
            if (value.length < 7) {
              return 'Password minimal terdiri dari 7 karakter';
            }
            final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{7,}$');
            if (!regex.hasMatch(value)) {
              return 'Password harus mengandung huruf besar dan angka';
            }
            return null;
          },
          obscureText: !_obsecureText!,
          controller: text_kontrol,
          onFieldSubmitted: (value) async {
            if (_formKey.currentState!.validate()) {
              HttpStatefull.loginAkun(textEditingControllerEmail.text,
                      textEditingControllerPassword.text)
                  .then((value) async => {
                        if (value.code == 200)
                          {
                            print("Nama anda adalah ${value.nama_lengkap}"),
                            print("ID Akun adalah ${value.id_akun}"),
                            print("Nik Akun adalah ${value.nik}"),
                            print(
                                "mamagambar Akun adalah ${value.namaProfile}"),
                            providerAccount!.AddData(
                                value.id_akun!,
                                value.nama_lengkap!,
                                value.nik!,
                                value.namaProfile!,
                                value.nomor_telepon!,
                                value.email!),
                            providerAccount!.setIdAkun(value.id_akun!.toInt()),
                            Navigator.pushNamed(
                                context, HalamanUtama.routeName.toString(),
                                arguments: value.id_akun),
                            FocusManager.instance.primaryFocus!.unfocus(),
                            ToastWidget.ToastSucces(context,
                                "Masuk Berhasil , Akun Ditemukan", "Selamat "),
                            UtilPref().saveSingleAccount(ModelAccount(
                                id_akun: value.id_akun,
                                nama: value.nama_lengkap,
                                Nik: value.nik,
                                urlGambar: value.namaProfile,
                                noTelepon: value.nomor_telepon,
                                email: value.email)),
                            UtilPref().saveLoginStatus(true)
                          }
                        else if (value.code == 400)
                          {
                            print("apakag eror kesini"),
                            ToastWidget.ToastEror(
                                context,
                                "Masuk Gagal , Akun Tidak Ditemukan",
                                "Mohon Maaf")
                          }
                      });
            }
          },
          textInputAction: TextInputAction.done,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    // setState(() {
                    //   passwordType = !passwordType!;
                    // });
                    _getVisibility();
                  },
                  icon: Icon(
                    passwordType! ? Icons.visibility : Icons.visibility_off,
                    color: ListColor.warnaBiruSidoKare,
                  )),
              hintText: hintText,
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ],
    );
  }

  Widget widgetTextForm(
      {TextEditingController? text_kontrol,
      String? hintText,
      String? labelName,
      bool? statusPasswordType = false,
      String? pesanValidasi}) {
    return Column(
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
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp)),
          textAlign: TextAlign.start,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty || value == null) {
              return "${pesanValidasi} Tidak Boleh Ksong";
            }
          },
          controller: text_kontrol,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal),
          obscureText: statusPasswordType!,
          decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: ListColor.warnaBiruSidoKare))),
        ),
      ],
    );
  }
}
