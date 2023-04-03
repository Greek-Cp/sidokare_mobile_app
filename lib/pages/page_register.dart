import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';

class PageRegister extends StatelessWidget {
  static String? routeName = "/register";
  TextEditingController textEditingControllerNama = TextEditingController();
  TextEditingController textEditingControllerUsername = TextEditingController();
  TextEditingController textEditingControllerNomorTelepon =
      TextEditingController();
  TextEditingController textEditingControllerKonfirmasiPassword =
      TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final providerAccount = Provider.of<ProviderAccount>(context);
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
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
                    Text(
                      "Daftarkan Akunmu ",
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.HeaderText.sp)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Silahkan buat akunmu terlebih dahulu",
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                        fontSize: size.SubHeader.sp,
                        color: ListColor.warnaDescription,
                      )),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      "assets/img_register.png",
                      width: 120.w,
                      height: 300.h,
                    ),
                    SizedBox(
                        child: TextFieldImport.TextForm(
                            text_kontrol: textEditingControllerNama,
                            hintText: "Masukkan Nama",
                            labelName: "Nama",
                            pesanValidasi: "Nama")),
                    SizedBox(
                        child: TextFieldImport.TextForm(
                            labelName: "Nama Pengguna",
                            text_kontrol: textEditingControllerUsername,
                            hintText: "Masukkan Nama Pengguna",
                            pesanValidasi: "Nama Pengguna")),
                    SizedBox(
                        child: TextFieldImport.TextForm(
                            labelName: "Email",
                            text_kontrol: textEditingControllerEmail,
                            hintText: "Masukkan Email",
                            pesanValidasi: "Email")),
                    SizedBox(
                        child: TextFieldImport.TextFormTelp(
                            labelName: "Nomor Telepon",
                            text_kontrol: textEditingControllerNomorTelepon,
                            hintText: "Masukkan Nomor Telepon",
                            pesanValidasi: "Nomor Telepon")),
                    SizedBox(
                        child: TextFieldPassword(
                            textEditingControllerPassword,
                            "Masukkan Password",
                            false,
                            "Password",
                            "Password")),
                    SizedBox(
                        child: TextFieldPassword(
                            textEditingControllerKonfirmasiPassword,
                            "Masukkan Ulang Password",
                            false,
                            "Ulangi Password",
                            "Password")),
                    SizedBox(
                      height: 10.w,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ListColor.warnaBiruSidoKare,
                            minimumSize: Size.fromHeight(55.h)),
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  if (providerAccount.registerAkun(
                                      nama: textEditingControllerNama.text
                                          .toString(),
                                      username: textEditingControllerUsername
                                          .text
                                          .toString(),
                                      email: textEditingControllerEmail.text
                                          .toString(),
                                      nomorTelepon:
                                          textEditingControllerNomorTelepon.text
                                              .toString(),
                                      password: textEditingControllerPassword
                                          .text
                                          .toString(),
                                      konfirmasiPassword:
                                          textEditingControllerKonfirmasiPassword
                                              .text
                                              .toString()))
                                    {
                                      ToastWidget.ToastSucces(
                                          context, "Register Berhasil")
                                    }
                                  else
                                    {
                                      ToastWidget.ToastEror(
                                          context, "Register gagal")
                                    }
                                }
                              else
                                {}
                            },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Daftar",
                            style: TextStyle(fontSize: size.textButton.sp),
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
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
