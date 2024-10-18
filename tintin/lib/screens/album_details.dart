import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/providers/reading_list_provider.dart';
import 'package:tintin/widgets/album_map.dart';

class AlbumDetails extends StatelessWidget {
  const AlbumDetails({super.key, required this.album});
  final Album album;

  @override
  Widget build(BuildContext context) {
    final TextStyle whiteTextStyle = TextStyle(color: Colors.white);
    final ReadingListProvider readingListProvider = Provider.of<ReadingListProvider>(context);

    return MaterialApp(
      title: album.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: Text(album.title, style: whiteTextStyle),
            centerTitle: true,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            actions: readingListProvider.contains(album) ? [
              IconButton(
                onPressed: () => readingListProvider.removeAlbum(album),
                icon: Icon(Icons.favorite, color: Colors.red),
              )
            ] : [
              IconButton(
                onPressed: () => readingListProvider.addAlbum(album),
                icon: Icon(Icons.favorite_border, color: Colors.white),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Album n°${album.numero}',
                      textAlign: TextAlign.center,
                      style: whiteTextStyle,
                    ),
                    Text(
                      'Année de parution : ${album.year}',
                      textAlign: TextAlign.center,
                      style: whiteTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: album.image.isNotEmpty ? Image.asset(album.image, height: 300, width: 300,) : Icon(Icons.add_a_photo, color: Colors.white, size: 300),
                          ),
                          Expanded(
                            child: Text(
                              'Résumé : ${album.resume}',
                              style: whiteTextStyle,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Latitude : ${album.gps.latitude}", style: whiteTextStyle),
                    Text("Longitude : ${album.gps.longitude}", style: whiteTextStyle),
                    AlbumMap(gps: album.gps, height: 400, width: 700),
                  ],
                )
            ),
          )
      ),
    );
  }
}
