import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  LatLng? positionMe;
  MapState stateMap = MapState.initial;

  void setInitialMap() async {
    stateMap = MapState.loading;
    var permissionLocation = await Geolocator.checkPermission();
    if (permissionLocation == LocationPermission.always ||
        permissionLocation == LocationPermission.whileInUse) {
      final GeolocatorPlatform _geolocatorPlatform =
          GeolocatorPlatform.instance;
      Position currentPosition = await _geolocatorPlatform.getCurrentPosition();

      positionMe = LatLng(currentPosition.latitude, currentPosition.longitude);
      stateMap = MapState.success;
    } else {
      await Geolocator.openLocationSettings();
    }
    notifyListeners();
  }
}

enum MapState { initial, loading, success }
