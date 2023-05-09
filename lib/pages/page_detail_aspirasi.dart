import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../component/jenis_button.dart';
import '../component/text_description.dart';
import '../component/text_field.dart';
import '../provider/provider_account.dart';

class PageDetailAspirasi extends StatefulWidget {
  static String routeName = "/formulir_detailstatusAspirasi";
  @override
  State<PageDetailAspirasi> createState() => _PageDetailAspirasiState();
}

class _PageDetailAspirasiState extends State<PageDetailAspirasi> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController setNama = TextEditingController();
  TextEditingController setNIK = TextEditingController();
  TextEditingController setJudulLaporan = TextEditingController();
  TextEditingController SetIsiLaporan = TextEditingController();
  TextEditingController SetUpload = TextEditingController();
  Map? getDataAspirasi;
  @override
  Widget build(BuildContext context) {
    getDataAspirasi = ModalRoute.of(context)?.settings.arguments as Map;
    int akunUser = getDataAspirasi?['id_akun'];
    String judulLaporan = getDataAspirasi?['judulLaporan'];
    String isiLaporan = getDataAspirasi?['isiLaporan'];
    String UploadFilePendukung = getDataAspirasi?['uploadFile'];

    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == akunUser);

    setState(() {
      setJudulLaporan.text = judulLaporan;
      SetIsiLaporan.text = isiLaporan;
      SetUpload.text = UploadFilePendukung;
      setNama.text = DataDiri.nama.toString();
      setNIK.text = DataDiri.Nik.toString();
    });

    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: ComponentTextTittle('Detail Status Aspirasi'),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(children: [
                TextFieldImport.TextFormNama(
                    labelName: "Nama Lengkap",
                    text_kontrol: setNama,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormTelp(
                    labelName: "NIK",
                    text_kontrol: setNIK,
                    length: 16,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Judul Laporan",
                    text_kontrol: setJudulLaporan,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormMultiLine(
                    labelName: "Isi Laporan",
                    readyOnlyTydack: true,
                    text_kontrol: SetIsiLaporan),
                TextFieldImport.TextFormNama(
                    labelName: "Upload File Pendukung",
                    text_kontrol: SetUpload,
                    readyOnlyTydack: true),
                ButtonForm("Ajukan Pembatalan", _formKey, () {})
              ]),
            )));
      },
    );
  }
}
