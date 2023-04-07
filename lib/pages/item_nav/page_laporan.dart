import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';

class PageLaporan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _MenuPpid(
                  Icons.assignment,
                  "Pengajuan PPID",
                  "Meminta informasi dokumen oleh \nbadan publik dan pemerintah ",
                  "Buat PPID"),
              _MenuPpid(
                  Icons.analytics,
                  "Lapor Keluhan",
                  "Melaporkan keluhan untuk \nmengatasi permasalahan ",
                  "Buat Keluhan"),
              _MenuPpid(
                  Icons.library_books_rounded,
                  "Lapor Aspirasi",
                  "Memberikan kritik dan saran \nuntuk pembangunan desa ",
                  "Buat Aspirasi")
            ],
          ),
        ),
      ),
    );
  }

  Widget _MenuPpid(
      IconData icons, String HeadText, String subText, String Button) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () => {},
        highlightColor: Colors.blue.withOpacity(0.4),
        splashColor: Colors.white.withOpacity(0.5),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                ListColor.GradientwarnaBiruSidoKare,
                ListColor.warnaBiruSidoKare
              ])),
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(icons),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HeadText,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      subText,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Text(
                          Button,
                          style: TextStyle(
                              color: ListColor.warnaBiruSidoKare,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
