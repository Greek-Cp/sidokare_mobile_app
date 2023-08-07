import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/const/util.dart';
import 'package:sidokare_mobile_app/model/api/http_statefull.dart';
import 'package:sidokare_mobile_app/pages/page_inputotp.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class PageRegister extends StatefulWidget {
  static String? routeName = "/register";

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController textEditingControllerNama = TextEditingController();
  TextEditingController textEditingControllerNik = TextEditingController();
  TextEditingController textEditingControllerUsername = TextEditingController();
  TextEditingController textEditingControllerNomorTelepon =
      TextEditingController();
  TextEditingController textEditingControllerKonfirmasiPassword =
      TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String? otp_register = UtilFunction.generateOTP().toString();
  final _formKey = GlobalKey<FormState>();

  sendMail(String? kodeOtp, String? email, BuildContext context) async {
    String username = 'e41211358@student.polije.ac.id';
    String password = 'ltddukvjccanwukp';
    var otpArray = kodeOtp.toString().split('');
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
        background: #1877F2; 
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
        font-size: 12px;
        font-weight: 700; 
        padding-bottom: .5em; 
        letter-spacing: 0.08em;
      }

      .welcome-message{
        text-align: center;
        font-weight: bold;
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
        background-color: #1877F2
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
                    <img src="https://i.imgur.com/6GdbHPj.png"> 
                </td>
              </tr>
    
            </table>
          </td>
         </tr>
        <tr><td>
          <table class="content">
            <tr><td colspan="5" class="welcome-message">VERIFIKASI KODE</td></tr>
            <tr><td colspan="5" class="header"> Email Penerima : ${email}</td></tr>
            <tr>
                
                <td colspan="2">Isi Pesan : Berikut Code Verifikasi yang harus anda masukkan ${otpArray[0]}${otpArray[1]}${otpArray[2]}${otpArray[3]}${otpArray[4]}</td>
            </tr>
              <tr>
                <td colspan="5">
                  <table class="table-width">
                    <tr>
                  </tr>
                
                    <tr><td class="footer-link">
                      <a href="#" class="link">Desa Sidokare</a>
      
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
      setState(() {
        _isLoading = false;
        print("akhir == ${_isLoading}");
      });
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

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement buil
    //

    // final providerAccount = Provider.of<ProviderAccount>(context);
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: _isLoading == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Harap Bersabar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "Proses daftar akun sedang berlangsung",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                )
              : SingleChildScrollView(
                  reverse: true,
                  // physics: NeverScrollableScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            FocusManager.instance.primaryFocus!
                                                .unfocus(),
                                            Navigator.pop(context)
                                          },
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
                                    hintText: "cth : ex@gmail.com",
                                    pesanValidasi: "Email")),
                            SizedBox(
                                child: TextFieldImport.TextFormTelp(
                                    labelName: "Nomor Telepon",
                                    length: 12,
                                    text_kontrol:
                                        textEditingControllerNomorTelepon,
                                    hintText: "Min 11 angka",
                                    pesanValidasi: "Nomor Telepon")),
                            SizedBox(
                                child: TextFieldPassword(
                                    textEditingControllerPassword,
                                    "terdiri : huruf besar , angka dan min 7 karakter",
                                    false,
                                    "Kata Sandi",
                                    "Kata Sandi")),
                            // SizedBox(
                            //     child: TextFieldPassword(
                            //         textEditingControllerKonfirmasiPassword,
                            //         "Masukkan Ulang Sandi",
                            //         false,
                            //         "Ulangi Kata Sandi",
                            //         "Kata Sandi")),
                            SizedBox(
                              child: PasswordDone(
                                  hintText: "Masukkan Ulang Sandi",
                                  passwordType: _obsecureText,
                                  labelName: "Ulangi kata Sandi",
                                  pesanValidasi: "Kata Sandi",
                                  text_kontrol:
                                      textEditingControllerKonfirmasiPassword),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ListColor.warnaBiruSidoKare,
                                    minimumSize: Size.fromHeight(55.h)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (textEditingControllerNik.text
                                            .toString()
                                            .length !=
                                        16) {
                                      ToastWidget.ToastEror(
                                          context,
                                          "NIK harus 16 karakter",
                                          "Teliti Lagi!");
                                    } else if (textEditingControllerNomorTelepon
                                            .text
                                            .toString()
                                            .length <
                                        11) {
                                      ToastWidget.ToastEror(
                                          context,
                                          "Nomer Telp harus 12 karakter",
                                          "Teliti Lagi");
                                    } else if (textEditingControllerKonfirmasiPassword
                                            .text
                                            .toString() !=
                                        textEditingControllerPassword.text
                                            .toString()) {
                                      ToastWidget.ToastEror(
                                          context,
                                          "Katasandi Tidak Sama",
                                          "Periksa Kembali");
                                    } else {
                                      setState(() {
                                        _isLoading = true;
                                        print("awal == ${_isLoading}");
                                      });
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
                                                    setState(() {
                                                      _isLoading = false;
                                                      print(
                                                          "akhir == ${_isLoading}");
                                                    }),
                                                    ToastWidget.ToastEror(
                                                        context,
                                                        "Daftar Gagal Akun Telah Ada",
                                                        "Teliti Lagi")
                                                  }
                                              });
                                    }
                                  } else {
                                    print("cuok mbuh");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Daftar",
                                    style:
                                        TextStyle(fontSize: size.textButton.sp),
                                  ),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom))
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
          obscureText: !passwordType!,
          controller: text_kontrol,
          onFieldSubmitted: (value) async {
            if (_formKey.currentState!.validate()) {
              if (textEditingControllerNik.text.toString().length != 16) {
                ToastWidget.ToastEror(
                    context, "NIK harus 16 karakter", "Teliti Lagi!");
              } else if (textEditingControllerNomorTelepon.text
                      .toString()
                      .length <
                  11) {
                ToastWidget.ToastEror(
                    context, "Nomer Telp harus 12 karakter", "Teliti Lagi");
              } else if (textEditingControllerKonfirmasiPassword.text
                      .toString() !=
                  textEditingControllerPassword.text.toString()) {
                ToastWidget.ToastEror(
                    context, "Katasandi Tidak Sama", "Periksa Kembali");
              } else {
                setState(() {
                  _isLoading = true;
                  print("awal == ${_isLoading}");
                });
                HttpStatefull.registerAkun(
                        email: textEditingControllerEmail.text,
                        password: textEditingControllerPassword.text,
                        username: textEditingControllerUsername.text,
                        nomor_telepon: textEditingControllerNomorTelepon.text,
                        kode_otp: otp_register.toString(),
                        nama_lengkap: textEditingControllerNama.text.toString(),
                        nik: textEditingControllerNik.text)
                    .then((value) => {
                          if (value.code == 200)
                            {
                              this.sendMail(
                                  otp_register.toString(),
                                  textEditingControllerEmail.text.toString(),
                                  context),
                            }
                          else
                            {
                              setState(() {
                                _isLoading = false;
                                print("akhir == ${_isLoading}");
                              }),
                              ToastWidget.ToastEror(context,
                                  "Daftar Gagal Akun Telah Ada", "Teliti Lagi")
                            }
                        });
              }
            } else {
              print("cuok mbuh");
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
            if (value!.isEmpty) {
              return "${pesanValidasi} Tidak Boleh Ksong";
            }
            return null;
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
