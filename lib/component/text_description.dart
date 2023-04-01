import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidokare_mobile_app/const/font_type.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class ComponentTextTittle extends StatelessWidget {
  String? textContent;
  TextAlign textAlign;
  Color warnaTeks = Colors.black;
  ComponentTextTittle(this.textContent,
      {this.textAlign = TextAlign.center, this.warnaTeks = Colors.black});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textHeader(
        textHeader_1: textContent.toString(),
        textAlign: textAlign,
        teksColor: warnaTeks);
  }

  Widget _textHeader(
      {Color teksColor = Colors.black,
      String textHeader_1 = "",
      TextAlign textAlign = TextAlign.center}) {
    return Text(
      "$textHeader_1",
      style: FontType.font_utama(
          fontSize: size.sizeHeader.sp,
          fontWeight: FontWeight.bold,
          color: teksColor),
      textAlign: this.textAlign,
    );
  }
}

class ComponentTextDescription extends StatelessWidget {
  String? textContent;
  TextAlign textAlign = TextAlign.center;
  Color teksColor = Colors.black;
  ComponentTextDescription(this.textContent,
      {this.textAlign = TextAlign.center, this.teksColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _textDesc(
        textDesc: textContent.toString(),
        textAlign: textAlign,
        teksColor: this.teksColor);
  }

  Widget _textDesc(
      {String textDesc = "",
      textAlign = TextAlign.center,
      Color teksColor = Colors.black}) {
    return Text(
      "$textDesc",
      style: FontType.font_utama(
          fontSize: size.sizeDescriptionPas.sp,
          fontWeight: FontWeight.normal,
          color: teksColor),
      textAlign: textAlign,
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
        fontSize: size.sizeDescriptionPas.sp,
        fontWeight: FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}
