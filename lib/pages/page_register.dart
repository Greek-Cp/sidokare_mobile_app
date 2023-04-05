import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/const/util.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/page_inputotp.dart';
import 'package:sidokare_mobile_app/pages/page_login.dart';
import 'package:sidokare_mobile_app/provider/provider_account.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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
  String? otp_register = UtilFunction.generateOTP().toString();
  final _formKey = GlobalKey<FormState>();

  sendMail(String? kodeOtp, String? email, BuildContext context) async {
    String username = 'e41211358@student.polije.ac.id';
    String password = 'ojmqzqkblieamunx';

    String templateMessage = """ 
    
    
    <!DOCTYPE html>
<html>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <head>
    <style>

      body{
        background: #E5E5E5 !important ; 
        font-family: 'Work Sans', sans-serif;
      }
      .button{
        background: #6D00C0; 
        color: #fff !important ; 
        border-radius: 3px; 
        display: block;
        text-decoration: none;
        padding: 15px;
        font-size: 16px; 
        text-align: center;
        margin-top: 60px;
      }
      .main-container{
        max-width: 29.375em;  
        width: 100%; 
        border-radius: 10px; 
        background: #ffffff;
        margin: 0 auto;
        border: #fff; 
      }

      .content{
        width: 80%;
        min-width: 23.9375em; 
        margin: 2em auto;
        font-size: 12px;
      }

      .link{
        color: #000; text-decoration: none;text-align: center;margin-bottom: 10px;
      }

      .title-text{
        font-weight: 600;
      }

      .header{
        font-size: 2.250em;
        font-weight: 600; 
        padding-bottom: .5em; 
        letter-spacing: -0.08em;
      }

      .welcome-message{
        font-size: 1em;
        padding-bottom: 1rem;
        letter-spacing: .5rem;
      }

      .img-container{
        padding: 0 3em;
        width: 100%;
        min-width: 23.9375em;
        height: 108px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px; 
        background-color: #6D00C0
      }

      .footer-link{
        text-align: center; 
        padding-top: 2em; 
        padding-bottom: .8em;
      }

      .icons{
        width: 60%; 
        margin: 0 auto
      }
  table{
  border-collapse: collapse !important;
  border: none;

}
      .table-width{
        width: 100%;
      }

      .text{
        font-weight: 500; 
        padding-top:1em ; 
        padding-bottom: .5em;
      }

    </style>
  </head>
    <body>
  
        <table class="main-container">
         <tr colspan="5">
          <td>
            <table class="table-width">
              <tr>
                <td colspan="5" class="img-container ">
                    <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814305/media/user_profile/jorazhh7bx9udn3jnp6t.png"> 
                </td>
              </tr>
    
            </table>
          </td>
         </tr>
        <tr><td>
          <table class="content">
            <tr><td colspan="5" class="welcome-message">SELAMAT DATANG</td></tr>
            <tr><td colspan="5" class="header">Daffa Aditya Rejasa</td></tr>
            <tr>
                <td colspan="2">Masukkan Kode Diatas Untuk Mengkonfimrasi Akun Anda</td>
            </tr>
              <tr>
                <td colspan="5">
                  <table class="table-width">
                    <tr><td colspan="5">
                      <a href="#" class="button">${this.otp_register.toString()}</a>
                      </td>
                  </tr>
                
                    <tr><td class="footer-link">
                      <a href="#" class="link">peerbarter.com</a>
      
                    </td></tr>
                 
      
                <tr>
                  <td>
                    <table class="icons">
                      <tr colspan ="5">
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814472/media/user_profile/grikcgydpd48hjyrkebs.png">
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814556/media/user_profile/bnbzay57s71dtfa3nx6k.png" >
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814490/media/user_profile/ohcadm3gcmpelhl5qaid.png" >
                          </a>
                        </td>
                        <td>
                          <a href="#">
                          <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814490/media/user_profile/ftusawk21cfahxyy0ji5.png" >
                        </a>
                        </td>
          
                            
                      </tr>
                    </table>
                  </td>
                </tr>
      
                  </table>
                </td>
              </tr>

          </table>
        </td></tr>

          </table>
      
    </body>
</html>
    """;
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Reuni321 TEAM')
      ..recipients.add(email)
      ..subject = 'Verifikasi Akun'
      ..html = templateMessage;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Navigator.pushNamed(context, InputOtp.routeName.toString(), arguments: {
        'email': textEditingControllerEmail.text.toString(),
        'otp': this.otp_register.toString(),
        'code_page': "toSuccesRegister"
      });
      ToastWidget.ToastSucces(context, "Daftar Berhasil");
    } on MailerException catch (e) {
      print('Message not sent.' + e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        ToastWidget.ToastEror(context, ' Format Email Tidak Sesuai');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buil
    //

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
                                      HttpStatefull.registerAkun(
                                              textEditingControllerEmail.text,
                                              textEditingControllerPassword
                                                  .text,
                                              textEditingControllerUsername
                                                  .text,
                                              textEditingControllerNomorTelepon
                                                  .text,
                                              otp_register.toString(),
                                              this
                                                  .textEditingControllerNama
                                                  .text
                                                  .toString())
                                          .then((value) => {
                                                if (value.code == 200)
                                                  {
                                                    this.sendMail(
                                                        otp_register.toString(),
                                                        textEditingControllerEmail
                                                            .text
                                                            .toString(),
                                                        context),
                                                  }
                                                else
                                                  {
                                                    ToastWidget.ToastEror(
                                                        context,
                                                        "Daftar Gagal Akun Telah Ada")
                                                  }
                                              })
                                    }
                                  else
                                    {
                                      ToastWidget.ToastEror(
                                          context, "Daftar Gagal")
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
