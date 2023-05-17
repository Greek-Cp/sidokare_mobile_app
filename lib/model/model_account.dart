class ModelAccount {
  int? id_akun;
  String? nama;
  String? username;
  String? email;
  String? noTelepon;
  String? password;
  String? Nik;
  String? urlGambar;

  ModelAccount({
    this.id_akun,
    this.nama,
    this.username,
    this.email,
    this.noTelepon,
    this.password,
    this.Nik,
    this.urlGambar,
  });

  factory ModelAccount.fromJson(Map<String, dynamic> json) {
    return ModelAccount(
      id_akun: json['id_akun'],
      nama: json['nama'],
      username: json['username'],
      email: json['email'],
      noTelepon: json['noTelepon'],
      password: json['password'],
      Nik: json['Nik'],
      urlGambar: json['urlGambar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_akun': id_akun,
      'nama': nama,
      'username': username,
      'email': email,
      'noTelepon': noTelepon,
      'password': password,
      'Nik': Nik,
      'urlGambar': urlGambar,
    };
  }
}
