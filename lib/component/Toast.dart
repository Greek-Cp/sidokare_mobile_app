import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class ToastWidget {
  static void ToastEror(BuildContext context, String txt) {
    return MotionToast.error(
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeIn,
        width: 280.w,
        height: 70.h,
        toastDuration: Duration(seconds: 2),
        animationType: AnimationType.fromTop,
        position: MotionToastPosition.top,
        description: Text(
          txt,
          style: TextStyle(fontSize: size.DescTextKecil.sp),
        )).show(context);
  }

  static void ToastSucces(BuildContext context, String txt) {
    return MotionToast.success(
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.easeIn,
            toastDuration: Duration(seconds: 2),
            animationType: AnimationType.fromTop,
            position: MotionToastPosition.top,
            description: Text(txt))
        .show(context);
  }
}
