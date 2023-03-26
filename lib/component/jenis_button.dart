import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class ButtonUtama extends StatelessWidget {
  String? routeName;
  String? buttonName;
  ButtonUtama(this.routeName, this.buttonName);
  @override
  Widget build(BuildContext context) {
    return _Button(context, routeName, buttonName);
  }

  Widget _Button(BuildContext context, String? routeName, String? buttonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName.toString());
        },
        child: ComponentTextButton("$buttonName"),
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
      ),
    );
  }
}

class ButtonForm extends StatefulWidget {
  Function? FungsiButton;
  String? namaButton;
  GlobalKey<FormState> _formKey;
  ButtonForm(this.namaButton, this._formKey, this.FungsiButton);
  @override
  State<ButtonForm> createState() =>
      _ButtonFormState(namaButton, _formKey, FungsiButton);
}

class _ButtonFormState extends State<ButtonForm> {
  final Function? FungsiButton;
  String? namaButton;
  GlobalKey<FormState> _formKey;
  _ButtonFormState(this.namaButton, this._formKey, this.FungsiButton);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _Button();
  }

  Widget _Button() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_formKey.currentState!.validate()) {
              FungsiButton!();
            }
          });
        },
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(55.h)),
        child: Text(
          "$namaButton ",
          style: TextStyle(fontSize: size.textButton.sp),
        ),
      ),
    );
  }
}
