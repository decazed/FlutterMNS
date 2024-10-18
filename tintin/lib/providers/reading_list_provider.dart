import 'package:flutter/material.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/services/hive_database_helper.dart';

class ReadingListProvider extends ChangeNotifier {
  late List<Album> _albums;

  ReadingListProvider() {
    _albums = [];
    _init();
  }

  Future<void> _init() async {
    _albums = await HiveDatabaseHelper().getAlbums();
    notifyListeners();
  }

  void addAlbum(Album album) {
    _albums.add(album);
    HiveDatabaseHelper().addAlbum(album);
    notifyListeners();
  }

  void removeAlbum(Album album) async {
    await HiveDatabaseHelper().deleteAlbum(album.numero);
    _albums.removeWhere((a) => a.numero == album.numero);
    notifyListeners();
  }


  Album getAlbumByNumero(int numero) {
    return _albums.firstWhere((album) => album.numero == numero);
  }

  List<Album> getAlbums() {
    return _albums;
  }

  bool contains(Album album) {
    return _albums.any((a) => a.numero == album.numero);
  }
}