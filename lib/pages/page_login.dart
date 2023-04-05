import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/fontfix.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/item_nav/page_utama.dart';
import 'package:sidokare_mobile_app/pages/page_home.dart';
import 'package:sidokare_mobile_app/pages/page_lupasandi.dart';
import 'package:sidokare_mobile_app/pages/page_register.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

class PageLogin extends StatefulWidget {
  static String? routeName = "/login";

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerAccount = Provider.of<ProviderAccount>(context);

    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.h),
              child: Form(
                key: _formKey,
                child: ListView(
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
                    Image.asset(
                      "assets/img_login.jpg",
                      width: 120.w,
                      height: 300.h,
                    ),
                    SizedBox(
                        child: TextFieldImport.TextForm(
                            labelName: "Email",
                            text_kontrol: textEditingControllerEmail,
                            hintText: "Masukkan Emailmu",
                            pesanValidasi: "Email")),
                    SizedBox(
                        child: TextFieldPassword(
                            textEditingControllerPassword,
                            "Masukkan Password",
                            false,
                            "Password",
                            "Password")),
                    SizedBox(
                      height: 10.sp,
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(
                            context, LupaSandi.routeName.toString())
                      },
                      child: Text(
                        "Lupa Password?",
                        style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: size.SubHeader.sp)),
                        textAlign: TextAlign.end,
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
                                          textEditingControllerPassword.text)
                                      .then((value) => {
                                            if (value.code == 200)
                                              {
                                                print(
                                                    "Nama anda adalah ${value.nama_lengkap}"),
                                                print(
                                                    "ID Akun adalah ${value.id_akun}"),
                                                providerAccount.AddData(
                                                    value.id_akun!,
                                                    value.nama_lengkap!),
                                                Navigator.pushNamed(
                                                    context,
                                                    HalamanUtama.routeName
                                                        .toString(),
                                                    arguments: value.id_akun),
                                                ToastWidget.ToastSucces(context,
                                                    "Masuk Berhasil , Akun Ditemukan")
                                              }
                                            else if (value.code == 400)
                                              {
                                                print("apakag eror kesini"),
                                                ToastWidget.ToastEror(context,
                                                    "Masuk Gagal , Akun Ditemukan")
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
                            style: TextStyle(fontSize: size.textButton.sp),
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
                            Navigator.pushNamed(
                                context, PageRegister.routeName.toString())
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
