import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/shimmer_loading.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';

class Tes {
  Widget ItemCardLaporan(
      {String? Jumlah, String? namaLaporan, IconData? iconnya}) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.h,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              iconnya,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Jumlah != "null"
                ? ComponentTextTittle(
                    Jumlah,
                    textAlign: TextAlign.start,
                    warnaTeks: Colors.white,
                  )
                : TextShimmer(),
            ComponentTextDescription(
              namaLaporan,
              textAlign: TextAlign.start,
              teksColor: Colors.white,
            )
          ],
        )
      ],
    );
  }

  Widget TentangDesa({String? Judul, String? assetImage}) {
    return Container(
      width: 270.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blue])),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${Judul}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white),
                ),
                Text("Sidokare",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white))
              ],
            ),
            Image.asset(
              "${assetImage}",
              scale: 1.2,
            )
          ],
        ),
      ),
    );
  }

  Widget maksid(
      {String? jmlahLaporan, String? ppid, String? keluhan, String? aspirasi}) {
    return Container(
      width: 270.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blue])),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemCardLaporan(
                    iconnya: Icons.all_inbox,
                    namaLaporan: "Total Laporan",
                    Jumlah: jmlahLaporan),
                ItemCardLaporan(
                    iconnya: Icons.assignment,
                    namaLaporan: "PPID",
                    Jumlah: ppid),
              ],
            ),
            // SizedBox(
            //   height: 25.h,
            //   width: 25.w,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemCardLaporan(
                    iconnya: Icons.analytics,
                    Jumlah: aspirasi,
                    namaLaporan: "Aspirasi"),
                ItemCardLaporan(
                    iconnya: Icons.library_books_rounded,
                    Jumlah: keluhan,
                    namaLaporan: "Keluhan"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
