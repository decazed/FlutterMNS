import 'package:flutter/material.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/services/album_service.dart';
import 'package:tintin/widgets/album_preview.dart';

class AlbumMaster extends StatelessWidget {
  const AlbumMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Albums',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Albums', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Album>>(
          future: AlbumService.fetchAlbums(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final albums = snapshot.data!;
              return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return Container(
                    margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                    color: Colors.white10,
                    child: AlbumPreview(album: album)
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
