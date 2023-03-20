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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              fontWeight: FontWeight.bold, fontSize: 20.sp)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Silahkan masuk dan lakukan aktivitas",
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                        fontSize: 15.sp,
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
                            hintText: "masukkan Emailmu",
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
                                fontStyle: FontStyle.italic, fontSize: 14.sp)),
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
                                  if (providerAccount.validateLogin(
                                      textEditingControllerEmail.text,
                                      textEditingControllerPassword.text))
                                    {
                                      MotionToast.success(
                                              description: Text(
                                                  "Login Berhasil,Akun Ditemukan"))
                                          .show(context)
                                    }
                                  else
                                    {
                                      // MotionToast.error(
                                      //         animationDuration:
                                      //             Duration(milliseconds: 300),
                                      //         animationCurve: Curves.easeIn,
                                      //         animationType:
                                      //             AnimationType.fromTop,
                                      //         position: MotionToastPosition.top,
                                      //         description: Text(
                                      //             "Login Gagal, Akun Tidak Ditemukan"))
                                      //     .show(context)
                                      ToastWidget.ndasmu(context,
                                          "Login Gagal, Akun Tidak Ditemukan")
                                    }
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
                                  fontSize: 14.sp)),
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
                                fontSize: 14.sp),
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
