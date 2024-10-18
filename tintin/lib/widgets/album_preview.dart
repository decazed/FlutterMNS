import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/screens/album_details.dart';
import '../models/album.dart';
import '../providers/reading_list_provider.dart';

class AlbumPreview extends StatelessWidget {
  const AlbumPreview({super.key, required this.album});
  final Album album;

  @override
  Widget build(BuildContext context) {
    final ReadingListProvider readingListProvider = Provider.of<ReadingListProvider>(context);

    return ListTile(
      title: Text(album.title, style: TextStyle(color: Colors.white)),
      leading: Image.asset(album.image),
      trailing: readingListProvider.contains(album) ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlbumDetails(key: key, album: album)));},
    );
  }
}