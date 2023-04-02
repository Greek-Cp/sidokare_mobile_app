import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/const/size.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../../const/list_color.dart';

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
        padding: const EdgeInsets.all(0.0),
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
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, offset: Offset(0.0, 1.0), //(x,y)
                  )
                ]),
            child: Container(
              foregroundDecoration: RotatedCornerDecoration.withColor(
                  color: ListColor.warnaBiruSidoKare,
                  badgeSize: Size(50.w, 50.h),
                  badgePosition: BadgePosition.bottomStart,
                  textDirection: TextDirection.rtl,
                  badgeCornerRadius: Radius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [_ImagesBruh(), _TextDesc(), _KetBawah()],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: () {},
              icon: Icon(Icons.date_range),
              padding: EdgeInsets.all(0),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sep 9, 2022",
                  style: TextStyle(
                      color: ListColor.warnaDescriptionItem,
                      fontSize: size.SubHeader.sp - 3),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(),
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(Icons.send),
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ),
            )
          ],
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
