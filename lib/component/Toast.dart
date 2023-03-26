import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ToastWidget {
  static void ToastEror(BuildContext context, String txt) {
    return MotionToast.error(
            animationDuration: Duration(milliseconds: 300),
            animationCurve: Curves.easeIn,
            toastDuration: Duration(seconds: 2),
            animationType: AnimationType.fromTop,
            position: MotionToastPosition.top,
            description: Text(txt))
        .show(context);
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
