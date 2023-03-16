import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      height: 50.h,
                    ),
                    Text(
                      "Mari Daftarkan Akunmu ",
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Silahkan buat akunmu terlebih dahulu",
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                        fontSize: 15.sp,
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
                        child: widgetTextForm(
                            labelName: "Nama",
                            text_kontrol: textEditingControllerNama,
                            hintText: "Masukkan Nama",
                            pesanValidasi: "Nama")),
                    SizedBox(
                        child: widgetTextForm(
                            labelName: "Username",
                            text_kontrol: textEditingControllerUsername,
                            hintText: "Masukkan Username",
                            statusPasswordType: false,
                            pesanValidasi: "Username")),
                    SizedBox(
                        child: widgetTextForm(
                            labelName: "Email",
                            text_kontrol: textEditingControllerEmail,
                            hintText: "Masukkan Email",
                            statusPasswordType: false,
                            pesanValidasi: "Email")),
                    SizedBox(
                        child: widgetTextForm(
                            labelName: "Nomor Telepon",
                            text_kontrol: textEditingControllerNomorTelepon,
                            hintText: "Masukkan Nomor Telepon",
                            statusPasswordType: false,
                            pesanValidasi: "Nomor Telepon")),
                    SizedBox(
                        child: widgetTextForm(
                            labelName: "Password",
                            text_kontrol: textEditingControllerPassword,
                            hintText: "Masukkan Password",
                            statusPasswordType: true,
                            pesanValidasi: "Password")),
                    SizedBox(
                        child: widgetTextForm(
                            labelName: "Konfirmasi Password",
                            text_kontrol:
                                textEditingControllerKonfirmasiPassword,
                            hintText: "Masukkan Ulang Password",
                            statusPasswordType: true,
                            pesanValidasi: "Password Konfirmasi")),
                    SizedBox(
                      height: 10.sp,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ListColor.warnaKuning)),
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
                                      MotionToast.success(
                                              description:
                                                  Text("Registerasi Berhasil"))
                                          .show(context)
                                    }
                                  else
                                    {
                                      MotionToast.error(
                                              description:
                                                  Text("Registerasi Gagal"))
                                          .show(context)
                                    }
                                }
                              else
                                {}
                            },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Daftar",
                            style: TextStyle(fontSize: 20.sp),
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
                      BorderSide(width: 1, color: ListColor.warnaKuning)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaKuning)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: ListColor.warnaKuning))),
        ),
      ],
    );
  }
}
