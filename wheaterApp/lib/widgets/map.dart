import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng center;
  final double zoom;
  final LatLng userLocation;

  MapWidget({required this.center, required this.zoom, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: zoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: userLocation,
              width: 40,
              height: 40,
              child: Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}
