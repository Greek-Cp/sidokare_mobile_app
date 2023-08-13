import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/page_berhasildaftar.dart';
import 'package:sidokare_mobile_app/pages/page_berhasilotp.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';

import '../component/Toast.dart';
import '../const/list_color.dart';

class UbahSandi extends StatefulWidget {
  static String? routeName = "/UbahSandi";
  @override
  State<UbahSandi> createState() => _UbahSandiState();
}

class _UbahSandiState extends State<UbahSandi> {
  bool _passwordvisible = false;
  bool _passwordvisible2 = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputSandi = TextEditingController();
  TextEditingController inputSandi2 = TextEditingController();

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity(context);
    super.initState();
    _passwordvisible = false;
    _passwordvisible2 = false;
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

  @override
  Widget build(BuildContext context) {
    final getEmail = ModalRoute.of(context)?.settings.arguments as String;
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            reverse: true,
            child: Container(
                child: SafeArea(
              child: Center(
                child: Padding(
                  padding: size.paddingHorizontalAwalFrame,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: Icon(Icons.arrow_back)),
                            ]),
                        SizedBox(
                          height: 20.h,
                        ),
                        _HeaderText(),
                        _DescHeaderText(),
                        _ImageLupaKataSandi(),
                        TextFieldPassword(inputSandi2, "Masukkan Kata Sandimu",
                            _passwordvisible2, "kata Sandi", "Harap diisi"),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFieldPassword(
                            inputSandi,
                            "Masukkan Ulang Kata Sandimu",
                            _passwordvisible,
                            "Konfirmasi kata Sandi",
                            "Harap disi"),
                        getBruh(getEmail),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }

  Widget getBruh(String namaEmailTerbawah) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ListColor.warnaBiruSidoKare,
              minimumSize: Size.fromHeight(55.h)),
          onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    print("email terbawah = ${namaEmailTerbawah}"),
                    if (inputSandi.text.toString() ==
                        inputSandi2.text.toString())
                      {
                        HttpStatefull.ubahSandi(
                                namaEmailTerbawah, inputSandi.text.toString())
                            .then((value) => {
                                  if (value.code == 200)
                                    {
                                      print("berhasil bruh"),
                                      Navigator.pushNamed(context,
                                          berhasildaftar.routeName.toString()),
                                    }
                                })
                      }
                    else
                      {
                        print("Password Tidak Sama"),
                        ToastWidget.ToastEror(
                            context, "Password Tidak Sama", "Periksa Ulang!")
                      }
                  }
              },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Ubah Sandi",
              style: TextStyle(fontSize: size.textButton.sp),
            ),
          )),
    );
  }

  Widget _HeaderText() {
    return Text(
      "Ubah Sandi",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh,
          fontWeight: FontWeight.bold,
          fontSize: size.HeaderText.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _DescHeaderText() {
    return Text(
      "Silahkan masukkan kode otp ",
      style: TextStyle(
          fontFamily: fontfix.DmSansBruh, fontSize: size.SubHeader.sp),
      textAlign: TextAlign.center,
    );
  }

  Widget _ImageLupaKataSandi() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          "assets/imageubahsandi.png",
          width: 260.w,
          height: 256.h,
        ),
      ),
    );
  }

  Widget _inputSandiSatu(
    String hint,
    String labelAtas,
  ) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            labelAtas,
            style: TextStyle(fontFamily: fontfix.DmSansBruh),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: !_passwordvisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordvisible = !_passwordvisible;
                    });
                  },
                  icon: Icon(
                    _passwordvisible ? Icons.visibility : Icons.visibility_off,
                    color: ListColor.warnaBiruSidoKare,
                  )),
              hintText: hint,
              hintStyle: TextStyle(fontFamily: fontfix.DmSansBruh),
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: ListColor.warnaBiruSidoKare,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
      ],
    );
  }

  Widget _inputSandiDua(
    String hint,
    String labelAtas,
  ) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            labelAtas,
            style: TextStyle(fontFamily: fontfix.DmSansBruh),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: !_passwordvisible2,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordvisible2 = !_passwordvisible2;
                    });
                  },
                  icon: Icon(
                    _passwordvisible2 ? Icons.visibility : Icons.visibility_off,
                    color: ListColor.warnaBiruSidoKare,
                  )),
              hintText: hint,
              hintStyle: TextStyle(fontFamily: fontfix.DmSansBruh),
              contentPadding: EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: ListColor.warnaBiruSidoKare,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaBiruSidoKare),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
      ],
    );
  }

  Widget _ButtonUbah() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Text(
          "Ubah Kata Sandi",
          style: TextStyle(fontFamily: fontfix.DmSansBruh),
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55)),
      ),
    );
  }
}
