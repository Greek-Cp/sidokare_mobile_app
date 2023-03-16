import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:collection/collection.dart';

class ProviderAccount extends ChangeNotifier {
  List<ModelAccount> listAccount = [];

  bool validateLogin(String? email, String? password) {
    if (!email!.isEmpty && !password!.isEmpty) {
      var accountSelected = listAccount.firstWhereOrNull(
          (element) => element.email == email && element.password == password);
      if (accountSelected != null) {
        print("akun ditemukan");
        return true;
      }
    }
    print("akun tidak ditemukan");
    return false;
  }

  bool registerAkun(
      {String? nama,
      username,
      email,
      nomorTelepon,
      password,
      konfirmasiPassword}) {
    if (password == konfirmasiPassword) {
      listAccount
          .add(ModelAccount(nama, username, email, nomorTelepon, password));
      notifyListeners();
      print("Register Berhasil");
      return true;
    } else {
      print("Register Gagal");
      return false;
    }
  }

  bool login({String? email, String? password}) {
    return validateLogin(email, password);
  }
}
