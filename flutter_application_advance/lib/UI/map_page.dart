import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(-6.256084902522864, 106.62023054574239), zoom: 16),
        markers: {
          Marker(
              markerId: MarkerId('marker-1'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position: LatLng(-6.255922785156193, 106.61851755190807),
              infoWindow: InfoWindow(title: 'Location 1')),
          Marker(
              markerId: MarkerId('marker-2'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueMagenta),
              position: LatLng(-6.255273746451913, 106.62088441028745),
              infoWindow: InfoWindow(title: 'Location 2'))
        },
      ),
    );
  }
}
