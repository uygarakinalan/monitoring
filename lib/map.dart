import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

import 'model/device.dart';
import 'model/environment_data.dart';
import 'service/api_helper.dart';
import 'service/future_service.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String deviceUrl =
      'https://opendataapi.gaziantep.bel.tr/api/Environment/GetDeviceList';
  String deviceByIdUrl =
      'https://opendataapi.gaziantep.bel.tr/api/Environment/GetEnvironmentDatasByDeviceId';

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
            future: futureService.getDeviceList(deviceUrl),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart),
                            label: Text('AKTİF KUTU SAYISI'),
                          ),
                        ),
                        FlutterMap(
                          options: MapOptions(
                            center:
                                LatLng(37.06593866282409, 37.37421071813484),
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
                              markers: _buildMarkersOnMap(
                                  snapshot.data as List<Device>),
                            ),
                          ],
                        )
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

  showAlertDialog(BuildContext context, int deviceId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: FutureBuilder(
        future: futureService.getEnvironmentDataListByDeviceId(
            deviceByIdUrl + '?deviceId=$deviceId'),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          trailing: Text(
                            snapshot.data![index].durum.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("List item "));
                    });
              } else {
                final error = snapshot.error as DioError;
                return Text('$error');
              }
            default:
              return Text('');
            /* return Lottie.network(
                  'https://assets4.lottiefiles.com/private_files/lf30_jmgekfqg.json');
         */
          }
        },
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Marker> _buildMarkersOnMap(List<Device> devices) {
    List<Marker> markers = <Marker>[];

    for (var element in devices) {
      var marker = Marker(
          point: LatLng(double.parse(element.latitude.toString()),
              double.parse(element.longtitude.toString())),
          width: 300,
          height: 300,
          builder: (context) => IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: FaIcon(FontAwesomeIcons.sunPlantWilt),
              onPressed: () {
                showAlertDialog(context, element.deviceId!);
                //print(element.deviceId);
              }));
      markers.add(marker);
    }
    return markers;
  }
}
