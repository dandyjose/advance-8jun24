import 'package:flutter/material.dart';
import 'package:flutter_application_advance/commons/constant.dart';
import 'package:flutter_application_advance/provider/map_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    context.read<MapProvider>().setInitialMap();
  }

  String calculateRadius(LatLng location, LatLng positionMe) {
    var radius = Geolocator.distanceBetween(positionMe.latitude,
        positionMe.longitude, location.latitude, location.longitude);
    return radius.toString();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MapProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('View Map'),
      ),
      body: provider.stateMap == MapState.loading
          ? Center(
            child: Shimmer.fromColors(
                baseColor: Colors.blue,
                highlightColor: Colors.blueGrey,
                child: Text(
                  'Load Map',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          )
          : provider.stateMap == MapState.success
              ? bodyMap(provider.positionMe!)
              : SizedBox(),
    );
  }

  Widget bodyMap(LatLng positionMe) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: positionMe, zoom: 16),
      polylines: {},
      markers: {
        Marker(
            markerId: MarkerId('marker-0'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: positionMe!,
            infoWindow: InfoWindow(title: 'My Location')),
        for (int index = 0; index < listLocation.length; index++)
          Marker(
              markerId: MarkerId('marker-${index + 1}'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
              position: listLocation[index],
              infoWindow: InfoWindow(
                  title: 'Location ${index + 1}',
                  snippet: calculateRadius(listLocation[index], positionMe))),
      },
    );
  }
}
