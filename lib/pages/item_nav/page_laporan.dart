import 'package:flutter/material.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';

class PageLaporan extends StatefulWidget {
  @override
  State<PageLaporan> createState() => _PageLaporanState();
}

class _PageLaporanState extends State<PageLaporan> {
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;

  List<IconData> iconssnya = [
    Icons.assignment,
    Icons.analytics,
    Icons.library_books_rounded
  ];

  List<String> HeaderJudul = [
    "Pengajuan PPID",
    "Lapor Keluhan",
    "Lapor Aspirasi"
  ];
  List<String> DescHead = [
    "Meminta informasi dokumen oleh \nbadan publik dan pemerintah",
    "Melaporkan keluhan untuk \nmengatasi permasalahan",
    "Memberikan kritik dan saran \nuntuk pembangunan desa"
  ];
  List<String> namaButton = ["Buat PPID", "Buat Keluhan", "Buat Aspirasi"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: DescHead.length,
            itemBuilder: (context, index) {
              return _MenuPpid(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _MenuPpid(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () => {},
        highlightColor: Colors.blue.withOpacity(0.4),
        splashColor: Colors.white.withOpacity(0.5),
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300 + (index * 200)),
          transform:
              Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
          width: screenWidth,
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
                child: Icon(iconssnya[index]),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${HeaderJudul[index]}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "${DescHead[index]}",
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
                          "${namaButton[index]}",
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
