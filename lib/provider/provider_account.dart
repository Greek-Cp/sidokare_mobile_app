import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/model/model_account.dart';
import 'package:collection/collection.dart';
import 'package:sidokare_mobile_app/model/response/berita.dart';

class ProviderAccount extends ChangeNotifier {
  int? id_akun;

  void setIdAkun(int id_akun) {
    this.id_akun = id_akun;
    print("Id Akun Berhasil Di Set");
    notifyListeners();
  }

  int getIdAkun() {
    return id_akun!;
  }

  int idAkun() {
    return id_akun!;
  }

  Berita? beritaSelected;
  void setBerita(Berita? berita) {
    this.beritaSelected = berita;
    notifyListeners();
  }

  get getBerita => beritaSelected;

  List<ModelAccount> listAccount = [];

  void setDataDiri(List<ModelAccount> listAccount) {
    print("Data Tersave");
    this.listAccount = listAccount;
    notifyListeners();
  }

  ModelAccount? getSingleAccount() {
    if (!listAccount.isEmpty && listAccount.length > 0) {
      return listAccount[0];
    }
  }

  //add Data
  List<ModelAccount> get GetDataDiri {
    return [...listAccount];
  }

  void AddData(int id_akun, String nama, String nik, String urlGambar,
      String NoTelponn, String emaill) {
    ModelAccount modelAccount = ModelAccount(
        id_akun: id_akun,
        nama: nama,
        Nik: nik,
        urlGambar: urlGambar,
        noTelepon: NoTelponn,
        email: emaill);
    id_akun = id_akun;
    setIdAkun(id_akun);
    listAccount.add(modelAccount);
    notifyListeners();
  }

  void updateData(int index, int id_akun, String nama, String nik,
      String urlGambar, String NoTelponn, String emaill) {
    listAccount[index] = ModelAccount(
        id_akun: id_akun,
        nama: nama,
        Nik: nik,
        urlGambar: urlGambar,
        noTelepon: NoTelponn,
        email: emaill);
    notifyListeners();
  }

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
      listAccount.add(ModelAccount(
          nama: nama,
          username: username,
          email: email,
          noTelepon: nomorTelepon,
          password: password));
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
