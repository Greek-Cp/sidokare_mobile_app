import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/controller_idakun.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/get/response_keluhan.dart';
import 'package:sidokare_mobile_app/model/response/get/response_ppid.dart';
import 'package:sidokare_mobile_app/pages/page_detail_keluhan.dart';

import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../item_page_detailPengajuan/page_DetailKeluhan.dart';

class itemListStatusKeluhan extends StatefulWidget {
  itemListStatusKeluhan(id_akun, jenis_pengajuan);

  @override
  State<itemListStatusKeluhan> createState() => _itemListStatusKeluhanState();
}

class _itemListStatusKeluhanState extends State<itemListStatusKeluhan> {
  Future<ResponseModelKELUHAN>? listData;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<ProviderAccount>(context);
    listData = ControllerAPI.getStatusKELUHAN(provider.getIdAkun());
    print("Pada keluhannn ${provider.getIdAkun()}");

    return Scaffold(
      body: Center(
        child: FutureBuilder<ResponseModelKELUHAN>(
          future: listData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.length != 0) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: FadeInAnimation(
                              child: index % 2 == 0
                                  ? FadeInAnimation(
                                      duration: Duration(milliseconds: 300),
                                      child: SlideAnimation(
                                          duration: Duration(milliseconds: 800),
                                          horizontalOffset: 350.0,
                                          child: _containerListStatus(
                                              judul_pengajuan: snapshot.data!
                                                  .data![index].judulLaporan
                                                  .toString(),
                                              idKeluh: snapshot
                                                  .data!
                                                  .data![index]
                                                  .idPengajuanKeluhan,
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              idAkun: snapshot
                                                  .data!.data![index].idAkun,
                                              isiLaporan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              laporan: snapshot.data!
                                                  .data![index].judulLaporan,
                                              asalPelapor: snapshot.data!
                                                  .data![index].asalPelapor,
                                              LocKejadian: snapshot.data!
                                                  .data![index].lokasiKejadian,
                                              KategoriLaporan: snapshot.data!
                                                  .data![index].kategoriLaporan,
                                              tglJadian: snapshot.data!
                                                  .data![index].tanggalKejadian,
                                              uploadFile: snapshot
                                                  .data!
                                                  .data![index]
                                                  .uploadFilePendukung,
                                              userRT: snapshot.data!.data![index].RT,
                                              userRw: snapshot.data!.data![index].RW,
                                              statusUser: snapshot.data!.data![index].statusUser,
                                              docUp: snapshot.data!.data![index].dokumenDown)),
                                    )
                                  : FadeInAnimation(
                                      duration: Duration(milliseconds: 300),
                                      child: SlideAnimation(
                                          duration: Duration(milliseconds: 800),
                                          horizontalOffset: -350.0,
                                          child: _containerListStatus(
                                              judul_pengajuan: snapshot.data!
                                                  .data![index].judulLaporan
                                                  .toString(),
                                              idKeluh: snapshot
                                                  .data!
                                                  .data![index]
                                                  .idPengajuanKeluhan,
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              idAkun: snapshot
                                                  .data!.data![index].idAkun,
                                              isiLaporan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              laporan: snapshot.data!
                                                  .data![index].judulLaporan,
                                              asalPelapor: snapshot.data!
                                                  .data![index].asalPelapor,
                                              LocKejadian: snapshot.data!
                                                  .data![index].lokasiKejadian,
                                              KategoriLaporan: snapshot.data!
                                                  .data![index].kategoriLaporan,
                                              tglJadian: snapshot.data!
                                                  .data![index].tanggalKejadian,
                                              uploadFile: snapshot
                                                  .data!
                                                  .data![index]
                                                  .uploadFilePendukung,
                                              userRT: snapshot.data!.data![index].RT,
                                              userRw: snapshot.data!.data![index].RW,
                                              statusUser: snapshot.data!.data![index].statusUser,
                                              docUp: snapshot.data!.data![index].dokumenDown)),
                                    )));
                      // return _containerListStatus(
                      //     judul_pengajuan: snapshot
                      //         .data!.data![index].judulLaporan
                      //         .toString(),
                      //     idKeluh:
                      //         snapshot.data!.data![index].idPengajuanKeluhan,
                      //     isi_pengajuan: snapshot.data!.data![index].isiLaporan,
                      //     idAkun: snapshot.data!.data![index].idAkun,
                      //     isiLaporan: snapshot.data!.data![index].isiLaporan,
                      //     laporan: snapshot.data!.data![index].judulLaporan,
                      //     asalPelapor: snapshot.data!.data![index].asalPelapor,
                      //     LocKejadian:
                      //         snapshot.data!.data![index].lokasiKejadian,
                      //     KategoriLaporan:
                      //         snapshot.data!.data![index].kategoriLaporan,
                      //     tglJadian:
                      //         snapshot.data!.data![index].tanggalKejadian,
                      //     uploadFile:
                      //         snapshot.data!.data![index].uploadFilePendukung,
                      //     userRT: snapshot.data!.data![index].RT,
                      //     userRw: snapshot.data!.data![index].RW,
                      //     statusUser: snapshot.data!.data![index].statusUser,
                      //     docUp: snapshot.data!.data![index].dokumenDown);
                    },
                    itemCount: snapshot.data!.data!.length);
              }
            } else {
              return CircularProgressIndicator();
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child:
                      Lottie.asset("assets/emptylist.json", fit: BoxFit.cover),
                ),
                Text(
                  "Belum ada list status Keluhan",
                  style:
                      TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  "silakan buat terlebih dahulu",
                  style: TextStyle(fontSize: 11.0.sp),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }

  Widget _containerListStatus(
      {String? judul_pengajuan,
      isi_pengajuan,
      idAkun,
      laporan,
      isiLaporan,
      asalPelapor,
      LocKejadian,
      statusUser,
      userRT,
      userRw,
      docUp,
      idKeluh,
      KategoriLaporan,
      tglJadian,
      uploadFile}) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul_pengajuan.toString().length > 20
                  ? judul_pengajuan.toString().substring(0, 20) + '...'
                  : "$judul_pengajuan",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.SubHeader.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isi_pengajuan.toString().length > 25
                      ? isi_pengajuan.toString().substring(0, 25) + '...'
                      : "$isi_pengajuan",
                  style: TextStyle(fontSize: size.DescTextKecil.sp),
                ),
                Container(
                  width: 110.0.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageDetailKeluhann.routeName.toString(),
                            arguments: {
                              "id_akun": idAkun,
                              "id_keluhan": idKeluh,
                              "judulLaporan": laporan,
                              "isiLaporan": isiLaporan,
                              "AsalPelapor": asalPelapor,
                              "RT": userRT,
                              "RW": userRw,
                              "statuss": statusUser,
                              "docOutAsp": docUp == null || docUp == ""
                                  ? "kosong"
                                  : docUp,
                              "LokasiKejadian": LocKejadian,
                              "KategoriLaporan": KategoriLaporan,
                              "TanggalKejadian": tglJadian,
                              "uploadFile": uploadFile != null ? uploadFile : ""
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: warnaButton(samakan: statusUser),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 5.h)),
                      child: Text(
                        statusUser.toString(),
                        style: TextStyle(fontSize: size.DescTextKecil.sp),
                      )),
                )
              ],
            ),
            Divider(
              height: 30.h,
              thickness: 1.h,
              color: ListColor.warnaBiruSidoKare,
            )
          ],
        ),
      ),
    );
  }
}
