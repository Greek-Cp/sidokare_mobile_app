import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';

class UtilPref {
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  Future<void> saveSingleAccount(ModelAccount? account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountJson = account != null ? jsonEncode(account.toJson()) : '';
    print("akun serializable = " + accountJson);
    prefs.setString('singleAccount', accountJson);
  }

  Future<ModelAccount> getSingleAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountJson = prefs.getString('singleAccount');
    Map<String, dynamic> accountMap = jsonDecode(accountJson.toString());
    return ModelAccount.fromJson(accountMap);
  }

  Future<void> removeSingleAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('singleAccount');
  }
}
