import 'package:flutter/material.dart';
import 'package:flutter_application_advance/commons/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? positionMe;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    var permissionLocation = await Geolocator.checkPermission();
    if (permissionLocation == LocationPermission.always ||
        permissionLocation == LocationPermission.whileInUse) {
      final GeolocatorPlatform _geolocatorPlatform =
          GeolocatorPlatform.instance;
      Position currentPosition = await _geolocatorPlatform.getCurrentPosition();
      setState(() {
        positionMe =
            LatLng(currentPosition.latitude, currentPosition.longitude);
      });
    } else {
      await Geolocator.openLocationSettings();
    }
  }

  String calculateRadius(LatLng location) {
    var radius = Geolocator.distanceBetween(positionMe!.latitude,
        positionMe!.longitude, location.latitude, location.longitude);
    return radius.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: positionMe!, zoom: 16),
        polylines: {},
        markers: {
          Marker(
              markerId: MarkerId('marker-0'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
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
                    snippet: calculateRadius(listLocation[index]))),
        },
      ),
    );
  }
}
