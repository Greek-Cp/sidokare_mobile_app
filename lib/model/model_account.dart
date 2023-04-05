import 'package:flutter/material.dart';

class ModelAccount {
  int? id_akun;
  String? nama;
  String? username;
  String? email;
  String? noTelepon;
  String? password;
  ModelAccount(
      {this.id_akun,
      this.nama,
      this.username,
      this.email,
      this.noTelepon,
      this.password});
}
