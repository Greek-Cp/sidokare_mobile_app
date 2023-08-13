import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sidokare_mobile_app/component/text_description.dart';

class MapSample extends StatefulWidget {
  static String? routname = "/PageMaps";

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.55787, 111.8734885),
    zoom: 14.9000,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-7.5600595, 111.8643586),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<LatLng> areaSidokare = [
    LatLng(-7.553899, 111.870105),
    LatLng(-7.550136, 111.870831),
    LatLng(-7.550330, 111.871584),
    LatLng(-7.549846, 111.871746),
    LatLng(-7.549864, 111.871825),
    LatLng(-7.549611, 111.871833),
    LatLng(-7.549628, 111.872002),
    LatLng(-7.549732, 111.872371),
    LatLng(-7.548984, 111.872547),
    LatLng(-7.548949, 111.872624),
    LatLng(-7.549116, 111.873128),
    LatLng(-7.549190, 111.873165),
    LatLng(-7.549300, 111.873415),
    LatLng(-7.549379, 111.873464),
    LatLng(-7.549373, 111.873556),
    LatLng(-7.549490, 111.873738),
    LatLng(-7.549778, 111.873649),
    LatLng(-7.549881, 111.873844),
    LatLng(-7.549854, 111.874073),
    LatLng(-7.549946, 111.874273),
    //
    LatLng(-7.549862, 111.874360),
    LatLng(-7.549893, 111.874442),
    LatLng(-7.550334, 111.874370),
    LatLng(-7.550730, 111.876585),
    LatLng(-7.553572, 111.876321),
    LatLng(-7.554162, 111.879196),
    LatLng(-7.554461, 111.879471),
    LatLng(-7.554656, 111.879488),
    LatLng(-7.555219, 111.879264),
    LatLng(-7.555253, 111.879436),
    LatLng(-7.555745, 111.879419),

    LatLng(-7.555930, 111.880377),
    LatLng(-7.558143, 111.879791),
    LatLng(-7.558274, 111.880945),
    LatLng(-7.561831, 111.880513),
    LatLng(-7.561115, 111.875741),
    LatLng(-7.561492, 111.875611),
    LatLng(-7.561570, 111.875403),
    LatLng(-7.560947, 111.872129),
    LatLng(-7.560989, 111.872071),

    LatLng(-7.561372, 111.871983),
    LatLng(-7.561468, 111.871899),
    LatLng(-7.562406, 111.871545),
    LatLng(-7.562723, 111.872448),
    LatLng(-7.566653, 111.871338),
    LatLng(-7.566780, 111.870693),
    LatLng(-7.566575, 111.869653),
    LatLng(-7.565890, 111.869043),
    LatLng(-7.565809, 111.868787),
    LatLng(-7.565878, 111.868502),
    LatLng(-7.565400, 111.868453),
    LatLng(-7.564840, 111.867921),
    LatLng(-7.564030, 111.867965),
    LatLng(-7.563292, 111.866870),
    LatLng(-7.563928, 111.866023),
    LatLng(-7.559749, 111.867054),
    LatLng(-7.559532, 111.866514),
    LatLng(
      -7.553538,
      111.868173,
    )
  ];

  MapType ThemaMap = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ComponentTextTittle(
          "Peta Desa Sidokare",
          warnaTeks: Colors.white,
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                onTap: () {
                  setState(() {
                    ThemaMap = MapType.normal;
                  });
                },
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text(
                      "Normal",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 3,
                onTap: () {
                  setState(() {
                    ThemaMap = MapType.hybrid;
                  });
                },
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(
                      Icons.maps_home_work_outlined,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text(
                      "Hybrid",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () {
                  setState(() {
                    ThemaMap = MapType.satellite;
                  });
                },
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(
                      Icons.satellite_outlined,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text(
                      "Satellite",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                onTap: () {
                  setState(() {
                    ThemaMap = MapType.terrain;
                  });
                },
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(
                      Icons.terrain,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text(
                      "Medan",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
            // offset: Offset(0, 100),
            color: Colors.white,
            elevation: 2,
            splashRadius: 10,
            icon: Icon(Icons.map_sharp),
            onCanceled: () {},
          )
        ],
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            GoogleMap(
              mapType: ThemaMap,
              initialCameraPosition: _kGooglePlex,
              polygons: {
                Polygon(
                    polygonId: PolygonId("1"),
                    points: areaSidokare,
                    fillColor: Color(0xFF006491).withOpacity(0.2),
                    strokeColor: Colors.grey.shade300,
                    strokeWidth: 1)
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenWidth,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lokasi Desa",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        """Desa Sidokare berada pada titik koordinat, garis lintang (latitude): -7.55787 dan garis bujur (longitude): 111.8734885, memiliki luas wilayah 175,16 ㎢.
                 """,
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
