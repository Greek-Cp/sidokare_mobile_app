import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:sidokare_mobile_app/model/controller_idakun.dart';
import 'package:sidokare_mobile_app/model/response/get/controller_get.dart';
import 'package:sidokare_mobile_app/model/response/get/response_aspirasi.dart';
import 'package:sidokare_mobile_app/model/response/get/response_keluhan.dart';
import 'package:sidokare_mobile_app/model/response/get/response_ppid.dart';

import 'package:sidokare_mobile_app/provider/provider_account.dart';

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
    listData = ControllerAPI.getStatusASPIRASI(provider.getIdAkun);

    return Scaffold(
      body: Center(
        child: FutureBuilder<ResponseModelASPIRASI>(
          future: listData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return _containerListStatus(
                        judul_pengajuan: snapshot
                            .data!.data![index].judulAspirasi
                            .toString(),
                        isi_pengajuan: snapshot.data!.data![index].isiAspirasi);
                  },
                  itemCount: snapshot.data!.data!.length);
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }

  Widget _containerListStatus({String? judul_pengajuan, isi_pengajuan}) {
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
                  : "$isi_pengajuan",
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
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h)),
                    child: Text(
                      "Ajukan",
                      style: TextStyle(fontSize: size.DescTextKecil.sp),
                    ))
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
