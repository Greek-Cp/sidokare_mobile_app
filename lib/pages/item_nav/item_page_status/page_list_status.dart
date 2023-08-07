import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/controller_idakun.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/get/response_ppid.dart';
import 'package:sidokare_mobile_app/pages/page_detail_status.dart';

import 'package:sidokare_mobile_app/provider/provider_account.dart';

import '../../item_page_detailPengajuan/page_DetailPengajuanPPID.dart';

class itemListStatus extends StatefulWidget {
  itemListStatus(id_akun, jenis_pengajuan);

  @override
  State<itemListStatus> createState() => _itemListStatusState();
}

class _itemListStatusState extends State<itemListStatus> {
  Future<ResponseModelPPID>? listData;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<ProviderAccount>(context);
    listData = ControllerAPI.getStatusPPID(provider.getIdAkun());

    return Scaffold(
      body: Center(
        child: FutureBuilder<ResponseModelPPID>(
          future: listData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("panjang data == ${snapshot.data!.data!.length}");
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
                                              id_ppid: snapshot.data!
                                                  .data![index].idPengajuanPpid,
                                              email: snapshot
                                                  .data!.data![index].email,
                                              NoTelp: snapshot
                                                  .data!.data![index].telpp,
                                              statusUser: snapshot
                                                  .data!.data![index].status,
                                              docUp: snapshot.data!.data![index].OutputDocPPID == null ||
                                                      snapshot.data!.data![index].OutputDocPPID ==
                                                          ""
                                                  ? "kosong"
                                                  : snapshot.data!.data![index]
                                                      .OutputDocPPID,
                                              RTuser: snapshot
                                                  .data!.data![index].RT,
                                              RWuser: snapshot
                                                  .data!.data![index].RW,
                                              judul_pengajuan: snapshot.data!
                                                  .data![index].judulLaporan
                                                  .toString(),
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              laporan: snapshot.data!.data![index].judulLaporan.toString(),
                                              isiLaporan: snapshot.data!.data![index].isiLaporan,
                                              asalPelapor: snapshot.data!.data![index].asalPelapor,
                                              kategoriPPID: snapshot.data!.data![index].kategoriPpid,
                                              uploadFile: snapshot.data!.data![index].uploadFilePendukung,
                                              idAkun: snapshot.data!.data![index].idAkun)),
                                    )
                                  : FadeInAnimation(
                                      duration: Duration(milliseconds: 300),
                                      child: SlideAnimation(
                                          duration: Duration(milliseconds: 800),
                                          horizontalOffset: -350.0,
                                          child: _containerListStatus(
                                              id_ppid: snapshot.data!
                                                  .data![index].idPengajuanPpid,
                                              email: snapshot
                                                  .data!.data![index].email,
                                              NoTelp: snapshot
                                                  .data!.data![index].telpp,
                                              statusUser: snapshot
                                                  .data!.data![index].status,
                                              docUp: snapshot.data!.data![index].OutputDocPPID == null ||
                                                      snapshot.data!.data![index].OutputDocPPID ==
                                                          ""
                                                  ? "kosong"
                                                  : snapshot.data!.data![index]
                                                      .OutputDocPPID,
                                              RTuser: snapshot
                                                  .data!.data![index].RT,
                                              RWuser: snapshot
                                                  .data!.data![index].RW,
                                              judul_pengajuan: snapshot.data!
                                                  .data![index].judulLaporan
                                                  .toString(),
                                              isi_pengajuan: snapshot.data!
                                                  .data![index].isiLaporan,
                                              laporan: snapshot.data!.data![index].judulLaporan.toString(),
                                              isiLaporan: snapshot.data!.data![index].isiLaporan,
                                              asalPelapor: snapshot.data!.data![index].asalPelapor,
                                              kategoriPPID: snapshot.data!.data![index].kategoriPpid,
                                              uploadFile: snapshot.data!.data![index].uploadFilePendukung,
                                              idAkun: snapshot.data!.data![index].idAkun)),
                                    )));
                      // return _containerListStatus(
                      //     id_ppid: snapshot.data!.data![index].idPengajuanPpid,
                      //     email: snapshot.data!.data![index].email,
                      //     NoTelp: snapshot.data!.data![index].telpp,
                      //     statusUser: snapshot.data!.data![index].status,
                      //     docUp: snapshot.data!.data![index].OutputDocPPID ==
                      //                 null ||
                      //             snapshot.data!.data![index].OutputDocPPID ==
                      //                 ""
                      //         ? "kosong"
                      //         : snapshot.data!.data![index].OutputDocPPID,
                      //     RTuser: snapshot.data!.data![index].RT,
                      //     RWuser: snapshot.data!.data![index].RW,
                      //     judul_pengajuan: snapshot
                      //         .data!.data![index].judulLaporan
                      //         .toString(),
                      //     isi_pengajuan: snapshot.data!.data![index].isiLaporan,
                      //     laporan: snapshot.data!.data![index].judulLaporan
                      //         .toString(),
                      //     isiLaporan: snapshot.data!.data![index].isiLaporan,
                      //     asalPelapor: snapshot.data!.data![index].asalPelapor,
                      //     kategoriPPID:
                      //         snapshot.data!.data![index].kategoriPpid,
                      //     uploadFile:
                      //         snapshot.data!.data![index].uploadFilePendukung,
                      //     idAkun: snapshot.data!.data![index].idAkun);
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
                  "Belum ada list status PPID",
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
      id_ppid,
      laporan,
      RTuser,
      RWuser,
      email,
      NoTelp,
      statusUser,
      docUp,
      isiLaporan,
      asalPelapor,
      kategoriPPID,
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
                  width: 110.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, DetailPengajuanPPID.routeName.toString(),
                            arguments: {
                              "id_ppid": id_ppid,
                              "id_akun": idAkun,
                              "judulLaporan": laporan,
                              "isiLaporan": isiLaporan,
                              "AsalPelapor": asalPelapor,
                              "RT": RTuser,
                              "RW": RWuser,
                              "email": email,
                              "tlp": NoTelp,
                              "status": statusUser,
                              "dokumenUp": docUp,
                              "kategoriPPID": kategoriPPID,
                              "uploadFile": uploadFile != null ? uploadFile : ""
                            });
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
