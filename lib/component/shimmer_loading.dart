import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidokare_mobile_app/component/Toast.dart';

class LoadingShimmerBerita extends StatelessWidget {
  double? LebarContainer;
  LoadingShimmerBerita({this.LebarContainer});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: LebarContainer,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 15,
                      width: 120,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 200,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: 200,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: 180,
                      color: Colors.white,
                    )
                  ]),
            ),
          ),
        )
      ],
    );
  }
}

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 7,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }
}

class ShimmerListStatus extends StatelessWidget {
  const ShimmerListStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: 130,
              height: 15,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 170,
                  height: 10,
                  color: Colors.white,
                ),
                Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 3,
              color: Colors.white,
            )
          ],
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }
}
