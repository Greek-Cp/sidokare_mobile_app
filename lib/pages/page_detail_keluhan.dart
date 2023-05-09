import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';

import '../component/jenis_button.dart';
import '../component/text_field.dart';
import '../provider/provider_account.dart';

class PageDetailKeluhan extends StatefulWidget {
  static String routeName = "/formulir_detailstatuskeluhan";
  @override
  State<PageDetailKeluhan> createState() => _PageDetailKeluhanState();
}

class _PageDetailKeluhanState extends State<PageDetailKeluhan> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController setNama = TextEditingController();
  TextEditingController setNIK = TextEditingController();
  TextEditingController setJudulLaporan = TextEditingController();
  TextEditingController SetIsiLaporan = TextEditingController();
  TextEditingController AsalLaporan = TextEditingController();
  TextEditingController LokasiLaporan = TextEditingController();
  TextEditingController KategoriLaporan = TextEditingController();
  TextEditingController TanggalLaporan = TextEditingController();
  TextEditingController setFile = TextEditingController();

  Map? getDataKeluhan;
  @override
  Widget build(BuildContext context) {
    getDataKeluhan = ModalRoute.of(context)?.settings.arguments as Map;
    String judulLaporan = getDataKeluhan?['judulLaporan'];
    String IsiLaporan = getDataKeluhan?['isiLaporan'];
    String asalLaporan = getDataKeluhan?['AsalPelapor'];
    String LokasiKejadian = getDataKeluhan?['LokasiKejadian'];
    String KategoriLaporanKeluhan = getDataKeluhan?['KategoriLaporan'];
    String Tanggal = getDataKeluhan?['TanggalKejadian'];
    String upfile = getDataKeluhan?['uploadFile'];
    int akunUser = getDataKeluhan?['id_akun'];
    final DataDiri = Provider.of<ProviderAccount>(context)
        .GetDataDiri
        .firstWhere((idData) => idData.id_akun == akunUser);

    setState(() {
      setNama.text = DataDiri.nama.toString();
      setNIK.text = DataDiri.Nik.toString();
      setJudulLaporan.text = judulLaporan;
      SetIsiLaporan.text = IsiLaporan;
      AsalLaporan.text = asalLaporan;
      LokasiLaporan.text = LokasiKejadian;
      KategoriLaporan.text = KategoriLaporanKeluhan;
      TanggalLaporan.text = Tanggal;
      setFile.text = upfile;
    });
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
            appBar: AppBar(
              title: ComponentTextTittle('Detail Status Keluhan'),
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
                    labelName: "Asal Laporan",
                    text_kontrol: AsalLaporan,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Lokasi Kejadian",
                    text_kontrol: LokasiLaporan,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Kategori Laporan",
                    text_kontrol: KategoriLaporan,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Tanggal Kejadian",
                    text_kontrol: TanggalLaporan,
                    readyOnlyTydack: true),
                TextFieldImport.TextFormNama(
                    labelName: "Upload File Pendukung",
                    text_kontrol: setFile,
                    readyOnlyTydack: true),
                ButtonForm("Ajukan Pembatalan", _formKey, () {})
              ]),
            )));
      },
    );
  }
}
