import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';

import '../provider/provider_account.dart';

class PageDetailStatus extends StatefulWidget {
  static String routeName = "/formulir_detailstatusppid";
  @override
  State<PageDetailStatus> createState() => _PageDetailStatusState();
}

class _PageDetailStatusState extends State<PageDetailStatus> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController setNama = TextEditingController();
  TextEditingController setNIK = TextEditingController();
  TextEditingController setJudulLaporan = TextEditingController();
  TextEditingController SetIsiLaporan = TextEditingController();
  TextEditingController AsalPelapor = TextEditingController();
  TextEditingController KategoriPPID = TextEditingController();
  TextEditingController UploadFile = TextEditingController();
  Map? getData;

  @override
  Widget build(BuildContext context) {
    getData = ModalRoute.of(context)?.settings.arguments as Map;
    int akunnnya = getData?['id_akun'];
    String judulLaporan = getData?['judulLaporan'];
    String isiLaporan = getData?['isiLaporan'];
    String asalPelaporr = getData?['AsalPelapor'];
    String kategori_ppid = getData?['kategoriPPID'];
    String uploaddd = getData?['uploadFile'];

    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == akunnnya);

    setState(() {
      setNama.text = DataDiri.nama.toString();
      setNIK.text = DataDiri.Nik.toString();
      setJudulLaporan.text = judulLaporan;
      SetIsiLaporan.text = isiLaporan;
      AsalPelapor.text = asalPelaporr;
      KategoriPPID.text = kategori_ppid;
      UploadFile.text = uploaddd;
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: ComponentTextTittle("Detail Status PPID"),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
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
                    labelName: "Asal Pelapor",
                    text_kontrol: AsalPelapor,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Kategori PPID",
                    text_kontrol: KategoriPPID,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Upload File Pendukung",
                    text_kontrol: UploadFile,
                    readyOnlyTydack: true),
                ButtonForm("Ajukan Pembatalan", _formKey, () {})
              ],
            ),
          ),
        );
      },
    );
  }
}
