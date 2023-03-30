import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class PagePemerintahanDesa extends StatefulWidget {
  @override
  State<PagePemerintahanDesa> createState() => _PagePemerintahanDesaState();
}

class _PagePemerintahanDesaState extends State<PagePemerintahanDesa> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListView(
          children: [
            _cardInformasi(),
            _cardInformasi(),
          ],
        ),
      ),
    );
  }

  Widget _cardInformasi() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey, offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [_ImagesBruh(), _TextDesc(), _KetBawah()],
          ),
        ),
      ),
    );
  }

  Widget _ImagesBruh() {
    return Image.asset(
      "assets/laptop.jpg",
      fit: BoxFit.contain,
    );
  }

  Widget _KetBawah() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.date_range),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(0),
              ),
              Text("9 September 2023"),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _TextDesc() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Hati-hati!! BMD akan mengadakan lomba",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.SubHeader),
          ),
        ),
        Text(
          "Para ibu-ibu muda Desa Sidokare telah menciptkan resep makan tradisional untuk merayakan lomba",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: size.sizeDescriptionPas),
        )
      ],
    );
  }
}
