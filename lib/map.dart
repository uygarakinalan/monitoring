import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

import 'model/device.dart';
import 'service/api_helper.dart';
import 'service/future_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ApiHelper apiHelper = ApiHelper();
  FutureService futureService = FutureService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {});
        }),
        body: FutureBuilder<List<Device>>(
            future: futureService.getDeviceList(
                'https://opendataapi.gaziantep.bel.tr/api/Environment/GetDeviceList'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return FlutterMap(
                      options: MapOptions(
                        center: LatLng(37.06593866282409, 37.37421071813484),
                        zoom: 18.0,
                      ),
                      mapController: MapController(),
                      children: [
                        TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']),
                        MarkerLayer(
                          rotate: true,
                          markers:
                              _buildMarkersOnMap(snapshot.data as List<Device>),
                        ),
                      ],
                    );
                  } else {
                    final error = snapshot.error as DioError;
                    return Text('');
                  }
                default:
                  return Text('');
                /* return Lottie.network(
                  'https://assets4.lottiefiles.com/private_files/lf30_jmgekfqg.json');
         */
              }
            }));
  }

  List<Marker> _buildMarkersOnMap(List<Device> devices) {
    List<Marker> markers = <Marker>[];
    for (var element in devices) {
      var marker = new Marker(
          point: LatLng(double.parse(element.latitude.toString()),
              double.parse(element.longtitude.toString())),
          width: 150,
          height: 150,
          builder: (context) => IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: FaIcon(FontAwesomeIcons.wheatAwnCircleExclamation),
              onPressed: () {
                print(element.deviceId);
              }));
      markers.add(marker);
    }

    return markers;
  }
}
