import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-3.997864, -79.200924),
          zoom: 17,
        ),
        zoomControlsEnabled: false,
        myLocationEnabled: true,
      ),
    );
  }
}
