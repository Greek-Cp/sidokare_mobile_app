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
  TextEditingController textEditingControllerNik = TextEditingController();
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
    var otpArray = kodeOtp.toString().split('');

    String templateMessage = """ 
    <!DOCTYPE html>
<html lang="en">
<head>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Poppins");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
body {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #4FAAF4;
}
:where(.container, form, .input-field, header) {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.container {
  background: #fff;
  padding: 35px 65px 50px 65px;
  border-radius: 20px;
  row-gap: 20px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, .1);
}
.container header{
  height: 150px;
  width: 150px;
  background-image: url('images/image.gif');
  background-size: cover;
  background-position: center;
}
.container h4 {
  font-size: 1.25rem;
  color: #333;
  font-weight: 500;
}
.container p {
  max-width: 250px;
  text-align: center;
  font-size: 13px;
}
.container p a {
  color: #4FAAF4;
  text-decoration: none;
}
.container p a:hover {
  text-decoration: underline;
}
form .input-field {
  flex-direction: row;
  column-gap: 10px;
}
form .input-field input {
  height: 50px;
  width: 43px;
  border-radius: 13px;
  outline: none;
  font-size: 1.125rem;
  text-align: center;
  border: 1px solid #ddd;
}
form .input-field input:focus {
  box-shadow: 0 1px 0 rgba(0, 0, 0, .1);
}
form .input-field input::-webkit-inner-spin-button,
form .input-field input::-webkit-outer-spin-button {
  display: none;
}
form button{
  margin-top: 25px;
  margin-bottom: 15px;
  width: 100%;
  color: #fff;
  font-size: 1rem;
  border: none;
  padding: 9px 0;
  cursor: pointer;
  border-radius: 15px;
  pointer-events: none;
  background: #1877F2;
  transition: all 0.2s ease;
}
form button.active {
  opacity: 1;
  pointer-events: auto;
}
form button:hover {
  background: #287ED4;
}
.icons{
        width: 60%; 
        margin: 0 auto
      }
    </style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
    <body>
        <div class="container">
          <header><img src="https://i.imgur.com/6GdbHPj.png" alt=""></header>
          <h4>Kode OTP</h4>
          <p>Masukkan Kode OTP pada Aplikasi Mobilemu</p>
          <form action="#">
            <div class="input-field">
             <input type="number" value="${otpArray[0]}" disabled/>
              <input type="number" value="${otpArray[1]}" disabled/>
              <input type="number" value="${otpArray[2]}" disabled/>
              <input type="number" value="${otpArray[3]}" disabled/>
              <input type="number" value="${otpArray[4]}" disabled/>
            </div>
           
          </form>
          <p>Desa Sidokare Kecamatan Rejoso<br> <a href="#"></a></p>
          <a href="#" class="icons">
            <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814472/media/user_profile/grikcgydpd48hjyrkebs.png">
            <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814556/media/user_profile/bnbzay57s71dtfa3nx6k.png">
            <img src="https://res.cloudinary.com/marykaystuff/image/upload/v1660814490/media/user_profile/ohcadm3gcmpelhl5qaid.png">
            </a>
            
        </div>
      
        <script src="script.js"></script>
      
    
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
      ToastWidget.ToastSucces(context, "Daftar Berhasil", "Selamat!!");
    } on MailerException catch (e) {
      print('Message not sent.' + e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        ToastWidget.ToastEror(
            context, ' Format Email Tidak Sesuai', 'Periksa Kembali!');
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
                        child: TextFieldImport.TextFormNama(
                            text_kontrol: textEditingControllerNama,
                            hintText: "Masukkan Nama",
                            labelName: "Nama",
                            pesanValidasi: "Nama")),
                    SizedBox(
                        child: TextFieldImport.TextFormTelp(
                            text_kontrol: textEditingControllerNik,
                            hintText: "Harus 16 angka",
                            length: 16,
                            labelName: "NIK",
                            pesanValidasi: "NIK")),
                    SizedBox(
                        child: TextFieldImport.TextForm(
                            labelName: "Nama Pengguna",
                            text_kontrol: textEditingControllerUsername,
                            hintText: "Masukkan Nama Pengguna",
                            pesanValidasi: "Nama Pengguna")),
                    SizedBox(
                        child: TextFieldImport.TextFormEmail(
                            labelName: "Email",
                            text_kontrol: textEditingControllerEmail,
                            hintText: "cth : ...@gmail.com",
                            pesanValidasi: "Email")),
                    SizedBox(
                        child: TextFieldImport.TextFormTelp(
                            labelName: "Nomor Telepon",
                            length: 12,
                            text_kontrol: textEditingControllerNomorTelepon,
                            hintText: "Min 11 angka",
                            pesanValidasi: "Nomor Telepon")),
                    SizedBox(
                        child: TextFieldPassword(
                            textEditingControllerPassword,
                            "cth : DsSidokare12",
                            false,
                            "Kata Sandi",
                            "Kata Sandi")),
                    SizedBox(
                        child: TextFieldPassword(
                            textEditingControllerKonfirmasiPassword,
                            "Masukkan Ulang Sandi",
                            false,
                            "Ulangi Kata Sandi",
                            "Kata Sandi")),
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
                                  if (textEditingControllerNik.text
                                          .toString()
                                          .length !=
                                      16)
                                    {
                                      ToastWidget.ToastEror(
                                          context,
                                          "NIK harus 16 karakter",
                                          "Teliti Lagi!")
                                    }
                                  else if (textEditingControllerNomorTelepon
                                          .text
                                          .toString()
                                          .length <
                                      11)
                                    {
                                      ToastWidget.ToastEror(
                                          context,
                                          "Nomer Telp harus 12 karakter",
                                          "Teliti Lagi")
                                    }
                                  else if (textEditingControllerKonfirmasiPassword
                                          .text
                                          .toString() !=
                                      textEditingControllerPassword.text
                                          .toString())
                                    {
                                      ToastWidget.ToastEror(
                                          context,
                                          "Katasandi Tidak Sama",
                                          "Periksa Kembali")
                                    }
                                  else
                                    {
                                      HttpStatefull.registerAkun(
                                              email: textEditingControllerEmail
                                                  .text,
                                              password:
                                                  textEditingControllerPassword
                                                      .text,
                                              username:
                                                  textEditingControllerUsername
                                                      .text,
                                              nomor_telepon:
                                                  textEditingControllerNomorTelepon
                                                      .text,
                                              kode_otp: otp_register.toString(),
                                              nama_lengkap:
                                                  textEditingControllerNama.text
                                                      .toString(),
                                              nik:
                                                  textEditingControllerNik.text)
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
                                                        "Daftar Gagal Akun Telah Ada",
                                                        "Teliti Lagi")
                                                  }
                                              })
                                    }
                                }
                              else
                                {print("cuok mbuh")}
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
