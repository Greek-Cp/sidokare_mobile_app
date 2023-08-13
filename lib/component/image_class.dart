import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../const/const.dart';

class ImageClass {
  static Widget ImageLupaKataSandi() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          "assets/imageubahsandi.png",
          width: 260,
          height: 256,
        ),
      ),
    );
  }
}

class BunderImageProfile extends StatelessWidget {
  String? namaGambar;
  double? lebarFoto;
  double? tinggiFoto;
  BunderImageProfile({this.namaGambar, this.lebarFoto, this.tinggiFoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebarFoto?.w,
      height: tinggiFoto?.h,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: CachedNetworkImage(
          imageUrl:
              "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${namaGambar?.replaceAll("'", "")}",
          height: 80.h,
          width: double.infinity,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          imageBuilder: (context, imageProvider) => Container(
                height: tinggiFoto?.h,
                width: lebarFoto?.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
          errorWidget: (context, url, error) {
            return Container(
                width: double.infinity,
                height: tinggiFoto?.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/accountBlank.png"))));
          },
          progressIndicatorBuilder: (context, url, progress) =>
              Shimmer.fromColors(
                  child: Container(
                      width: double.infinity,
                      height: tinggiFoto?.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      )),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100)),
    );
  }
}

class ChangeProfileBunder extends StatelessWidget {
  String? namaGambar;
  double? lebarFoto;
  double? tinggiFoto;
  File? fileGambar;
  ChangeProfileBunder(
      {this.namaGambar, this.lebarFoto, this.tinggiFoto, this.fileGambar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebarFoto?.w,
      height: tinggiFoto?.h,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: fileGambar == null
          ? CachedNetworkImage(
              imageUrl:
                  "http://${ApiPoint.BASE_URL}/storage/app/public/berita/${namaGambar?.replaceAll("'", "")}",
              height: 80.h,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              imageBuilder: (context, imageProvider) => Container(
                    height: tinggiFoto?.h,
                    width: lebarFoto?.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
              errorWidget: (context, url, error) {
                return Container(
                    width: double.infinity,
                    height: tinggiFoto?.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("assets/accountBlank.png"))));
              },
              progressIndicatorBuilder: (context, url, progress) =>
                  Shimmer.fromColors(
                      child: Container(
                          width: double.infinity,
                          height: tinggiFoto?.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          )),
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100))
          : CircleAvatar(
              backgroundImage: FileImage(fileGambar!),
              radius: 80,
            ),
    );
  }
}
