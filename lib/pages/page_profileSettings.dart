import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';

import '../const/list_color.dart';

class PageProfileUser extends StatefulWidget {
  static String? routeName = "/profilePic";
  @override
  State<PageProfileUser> createState() => _PageProfileUserState();
}

class _PageProfileUserState extends State<PageProfileUser> {
  TextEditingController getNama = TextEditingController();
  TextEditingController getNik = TextEditingController();
  TextEditingController getEmail = TextEditingController();
  TextEditingController getTelp = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getNama.text = "Daffa Aditya R R";
      getNik.text = "36868q68q68686";
      getEmail.text = "Daffaaditya12@gmail.com";
      getTelp.text = "092742477474";
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    ComponentTextTittle("Akun Saya"),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              maxRadius: 70,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 100, top: 90),
                              child: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: IconButton(
                                    color: Colors.amber,
                                    onPressed: () {},
                                    icon: Icon(Icons.mode_edit_outline)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextFieldImport.TextForm(
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
                        text_kontrol: getEmail,
                        pesanValidasi: "Telepon"),
                    TextFieldImport.TextForm(
                        labelName: "Nomor Telepon",
                        text_kontrol: getTelp,
                        pesanValidasi: "Telepon")
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
