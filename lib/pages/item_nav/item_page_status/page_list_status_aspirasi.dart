import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/controller_idakun.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/get/response_aspirasi.dart';
import 'package:sidokare_mobile_app/model/response/get/response_keluhan.dart';
import 'package:sidokare_mobile_app/model/response/get/response_ppid.dart';
import 'package:sidokare_mobile_app/pages/page_detail_aspirasi.dart';

import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../../component/shimmer_loading.dart';
import '../../item_page_detailPengajuan/page_DetailAspirasi.dart';

class itemListStatusAspirasi extends StatefulWidget {
  itemListStatusAspirasi(id_akun, jenis_pengajuan);

  @override
  State<itemListStatusAspirasi> createState() => _itemListStatusAspirasiState();
}

class _itemListStatusAspirasiState extends State<itemListStatusAspirasi> {
  Future<ResponseModelASPIRASI>? listData;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<ProviderAccount>(context);
    print("id akun =" + provider.getIdAkun().toString());
    listData = ControllerAPI.getStatusASPIRASI(provider.getIdAkun());

    return Scaffold(
      body: Center(
        child: FutureBuilder<ResponseModelASPIRASI>(
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
                                                  .data![index].judulAspirasi
                                                  .toString(),
                                              docUp: snapshot.data!.data![index]
                                                  .dokumenOutput,
                                              AspirasiId: snapshot
                                                  .data!
                                                  .data![index]
                                                  .idPengajuanAspirasi,
                                              statusUser: snapshot
                                                  .data!.data![index].status,
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiAspirasi,
                                              idAkun: snapshot
                                                  .data!.data![index].idAkun,
                                              laporan: snapshot.data!
                                                  .data![index].judulAspirasi
                                                  .toString(),
                                              isiLaporan: snapshot.data!
                                                  .data![index].isiAspirasi,
                                              uploadFile: snapshot
                                                  .data!
                                                  .data![index]
                                                  .uploadFilePendukung)),
                                    )
                                  : FadeInAnimation(
                                      duration: Duration(milliseconds: 300),
                                      child: SlideAnimation(
                                          duration: Duration(milliseconds: 800),
                                          horizontalOffset: -350.0,
                                          child: _containerListStatus(
                                              judul_pengajuan: snapshot.data!
                                                  .data![index].judulAspirasi
                                                  .toString(),
                                              docUp: snapshot.data!.data![index]
                                                  .dokumenOutput,
                                              AspirasiId: snapshot
                                                  .data!
                                                  .data![index]
                                                  .idPengajuanAspirasi,
                                              statusUser: snapshot
                                                  .data!.data![index].status,
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiAspirasi,
                                              idAkun: snapshot
                                                  .data!.data![index].idAkun,
                                              laporan: snapshot.data!
                                                  .data![index].judulAspirasi
                                                  .toString(),
                                              isiLaporan: snapshot.data!
                                                  .data![index].isiAspirasi,
                                              uploadFile: snapshot
                                                  .data!
                                                  .data![index]
                                                  .uploadFilePendukung)),
                                    )));
                      // return _containerListStatus(
                      //     judul_pengajuan: snapshot
                      //         .data!.data![index].judulAspirasi
                      //         .toString(),
                      //     docUp: snapshot.data!.data![index].dokumenOutput,
                      //     AspirasiId:
                      //         snapshot.data!.data![index].idPengajuanAspirasi,
                      //     statusUser: snapshot.data!.data![index].status,
                      //     isi_pengajuan: snapshot.data!.data![index].isiAspirasi,
                      //     idAkun: snapshot.data!.data![index].idAkun,
                      //     laporan: snapshot.data!.data![index].judulAspirasi
                      //         .toString(),
                      //     isiLaporan: snapshot.data!.data![index].isiAspirasi,
                      //     uploadFile:
                      //         snapshot.data!.data![index].uploadFilePendukung);
                    },
                    itemCount: snapshot.data!.data!.length);
              }
            } else if (snapshot.hasError) {
              return ShimmerListStatus();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
              // return ShimmerListStatus();
            } else {
              return CircularProgressIndicator();
            }
            //sini
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
                  "Belum ada list status Aspirasi",
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

  Color? warnaButton({String? samakan}) {
    if (samakan == "Diajukan") {
      return Colors.amberAccent;
    } else if (samakan == "Diproses") {
      ListColor.GradientwarnaBiruSidoKare;
    } else if (samakan == "Ditolak") {
      return Colors.redAccent;
    } else if (samakan == "Revisi") {
      return Colors.pinkAccent;
    } else if (samakan == "Direview") {
      return Colors.orangeAccent;
    } else if (samakan == "Selesai") {
      return Colors.lightGreen;
    } else {
      return Colors.greenAccent;
    }
  }

  Widget _containerListStatus(
      {String? judul_pengajuan,
      isi_pengajuan,
      idAkun,
      laporan,
      AspirasiId,
      docUp,
      statusUser,
      isiLaporan,
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
                SizedBox(
                  child: Text(
                    isi_pengajuan.toString().length > 25
                        ? isi_pengajuan.toString().substring(0, 25) + '...'
                        : "$isi_pengajuan",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: size.DescTextKecil.sp),
                  ),
                ),
                Container(
                  width: 110.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageDetailAspirasiiii.routeName.toString(),
                            arguments: {
                              "id_akun": idAkun,
                              "id_aspirasi": AspirasiId,
                              "status": statusUser,
                              "docOutAsp": docUp == null || docUp == ""
                                  ? "kosong"
                                  : docUp,
                              "judulLaporan": laporan,
                              "isiLaporan": isiLaporan,
                              "uploadFile": uploadFile != null ? uploadFile : ""
                            });
                        print("Tes Kon ${uploadFile}");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              warnaButton(samakan: statusUser.toString()),
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
