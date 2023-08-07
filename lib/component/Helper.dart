import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:open_settings/open_settings.dart';

class ConnectivityHelper extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> _subscription;
  bool _isDeviceConnected = true;
  bool _isAlertSet = false;

  void startListening(BuildContext context, bool turu) {
    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        _isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!_isDeviceConnected && !_isAlertSet) {
          showAlert(context, _isDeviceConnected, _isAlertSet);
          _isAlertSet = true;
          notifyListeners();
        }
      },
    );

    turu == true ? _subscription.cancel() : _subscription;
  }

  showAlert(BuildContext context, bool device, bool alert) {
    return Dialogs.bottomMaterialDialog(
      msg: 'Harap Periksa Ulang Koneksi / Internet',
      title: 'Tidak Ada Koneksi',
      color: Colors.white,
      lottieBuilder: Lottie.asset(
        "assets/koneks.json",
        fit: BoxFit.contain,
      ),
      context: context,
      enableDrag: false,
      isDismissible: false,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            // Navigator.of(context).pop();
            if (Platform.isAndroid) {
              OpenSettings.openWIFISetting();
            }

            // OpenSettings.openDateSetting();
          },
          text: 'Pengaturan',
          iconData: Icons.wifi,
          textStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            alert = false;
            notifyListeners();
            device = await InternetConnectionChecker().hasConnection;
            if (!device && alert == false) {
              showAlert(context, device, alert);
              alert = true;
              notifyListeners();
            }
          },
          text: 'Hubungkan',
          iconData: Icons.repeat,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
