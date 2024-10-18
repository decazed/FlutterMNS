import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Assurez-vous d'avoir importé cette bibliothèque
import 'package:tintin/screens/album_details.dart';
import '../models/album.dart';

class AlbumFullMap extends StatelessWidget {
  const AlbumFullMap({super.key, required this.albums});
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    final TextStyle whiteTextStyle = TextStyle(color: Colors.white);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    List<Marker> getMarkers() {
      return albums.map((album) {
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(album.gps.latitude, album.gps.longitude),
          child: IconButton(
            onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlbumDetails(album: album)));},
            icon: const Icon(Icons.location_on),
            color: const Color.fromARGB(255, 255, 7, 7),
          ),
        );
      }).toList();
    }

    return MaterialApp(
      title: 'MAP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('MAP', style: whiteTextStyle),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: FlutterMap(
              options: MapOptions(
                initialZoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(markers: getMarkers()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
