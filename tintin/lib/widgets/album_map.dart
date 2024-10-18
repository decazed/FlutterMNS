import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tintin/models/gps.dart';
import 'package:latlong2/latlong.dart';

class AlbumMap extends StatelessWidget {
  const AlbumMap({super.key, required this.gps, required this.height, required this.width});
  final GPS gps;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    print(gps);
    return SizedBox(
      height: height,
      width: width,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(gps.latitude, gps.longitude),
          initialZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(gps.latitude, gps.longitude),
              child: const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 255, 7, 7),
              ),
            ),
          ])
        ],
      )
    );
  }
}
