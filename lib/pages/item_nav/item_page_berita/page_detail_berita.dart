import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidokare_mobile_app/component/jenis_button.dart';
import 'package:sidokare_mobile_app/component/text_field.dart';
import 'package:sidokare_mobile_app/const/list_color.dart';
import 'package:sidokare_mobile_app/const/size.dart';

class PageDetailBerita extends StatefulWidget {
  @override
  State<PageDetailBerita> createState() => _PageDetailBeritaState();
}

class _PageDetailBeritaState extends State<PageDetailBerita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController getNama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      builder: (context, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => {},
                ),
                elevation: 10,
                shadowColor: ListColor.warnaBiruSidoKare,
                snap: false,
                floating: true,
                stretch: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: ListColor.warnaBiruSidoKare,
                pinned: true,
                expandedHeight: 180.w,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Hati - hati!! BMD akan mengadakan lomba Agustusan",
                    style: TextStyle(
                      fontSize: size.DescTextKecil.sp,
                    ),
                  ),
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 50.0.h, bottom: 20.0.h),
                  collapseMode: CollapseMode.parallax,
                  background: _Image("assets/laptop.jpg"),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _HeaderJudul(),
                  _ListMbu(),
                  AnimatedOpacity(
                      opacity: 1,
                      duration: Duration(milliseconds: 500),
                      child: _isiBerita()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Divider(
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                  _isiKomen(),
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _Image(String urlImage) {
    return Image(
      image: AssetImage(urlImage),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200.h,
    );
  }

  Widget _HeaderJudul() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Text(
        "Hati - hati!! BMD akan mengadakan lomba Agustusan",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size.HeaderText.sp),
      ),
    );
  }

  Widget _ListMbu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            color: Color.fromARGB(255, 236, 241, 255),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
              child: Text(
                "Pemerintahan Desa",
                style: TextStyle(fontSize: size.textButton.sp),
              ),
            ),
          ),
          Text(
            "20 Oct, 2023",
            style: TextStyle(fontSize: size.DescTextKecil.sp),
          ),
          CircleAvatar(
            radius: 10,
          ),
          Text("Deva Arie", style: TextStyle(fontSize: size.DescTextKecil.sp))
        ],
      ),
    );
  }

  Widget _isiBerita() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        "Para ibu-ibu muda Desa Sidokare telah menciptkan resep makan tradisional untuk merayakan lomba Momen peringatan Hari Kemerdekaan RI sering dimeriahkan dengan beragam lomba, mulai dari tingkat RT/RW sampai di sekolah dan kantor. Tujuan lomba ini biasanya menguji kekompakan warga.Jika Anda menjadi panitia dan masih bingung ingin mengadakan apa, simak 20 ide lomba 17 Agustus yang seru dan menarik berikut ini",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: size.sizeDescriptionPas.sp),
      ),
    );
  }

  Widget _isiKomen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Aktifitas Lainnya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.SubHeader.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: textFieldResponsive(hint: "Nama", radiusCorner: 10),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child:
                      textFieldMultiLineResponsive(hint: "Masukkan Komentar")),
              ButtonForm("Kirim Komentar", _formKey, KirimPesan()),
            ],
          )),
    );
  }

  Widget textFieldResponsive(
      {String? hint, double radiusCorner = 10, TextInputControl? controller}) {
    return TextFormField(
        style: TextStyle(fontSize: size.textButton.sp),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: 15.0.w, bottom: 1.0.h, top: 1.0.h, right: 5.0.w),
          hintText: "$hint",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusCorner.h)),
        ));
  }

  Widget textFieldMultiLineResponsive(
      {String? hint, double radiusCorner = 10, TextInputControl? controller}) {
    return TextFormField(
        style: TextStyle(fontSize: size.textButton.sp),
        minLines: 3,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "$hint",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radiusCorner.h)),
        ));
  }

  KirimPesan() {}
}
