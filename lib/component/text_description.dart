import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/const/font_type.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class ComponentTextTittle extends StatelessWidget {
  String? textContent;
  ComponentTextTittle(this.textContent);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textHeader(textHeader_1: textContent.toString());
  }

  Widget _textHeader({String textHeader_1 = ""}) {
    return Text(
      "$textHeader_1",
      style: FontType.font_utama(
          fontSize: size.sizeHeader.sp, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class ComponentTextDescription extends StatelessWidget {
  String? textContent;
  ComponentTextDescription(this.textContent);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textDesc(textDesc: textContent.toString());
  }

  Widget _textDesc({String textDesc = ""}) {
    return Text(
      "$textDesc",
      style: FontType.font_utama(
        fontSize: size.sizeDescription.sp,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ComponentTextButton extends StatelessWidget {
  String? namaButton;
  ComponentTextButton(this.namaButton);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textDesc(textDesc: namaButton.toString());
  }

  Widget _textDesc({String textDesc = ""}) {
    return Text(
      "$textDesc",
      style: FontType.font_utama(
        fontSize: size.sizeDescription.sp,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}
