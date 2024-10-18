import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/screens/album_details.dart';
import '../models/album.dart';
import '../providers/reading_list_provider.dart';
import '../screens/album_full_map.dart';

class AlbumMapPreview extends StatelessWidget {
  const AlbumMapPreview({super.key, required this.albums});
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlbumFullMap(albums: albums)));},
      icon: Icon(Icons.map, color: Colors.white),
    );
  }
}