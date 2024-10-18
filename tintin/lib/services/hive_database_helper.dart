import 'package:hive/hive.dart';
import '../models/album.dart';

class HiveDatabaseHelper {
  static const String albumsBoxName = "albumsBox";

  static Future<void> initHive() async {
    await Hive.openBox<Album>(albumsBoxName);
  }

  Future<void> insertAlbum(Album album) async {
    var box = await Hive.openBox<Album>(albumsBoxName);
    box.put(album.numero, album);  // Utilise numero comme clé
  }

  Future<void> deleteAlbum(int numero) async {
    var box = await Hive.openBox<Album>(albumsBoxName);
    box.delete(numero);
  }

  Future<List<Album>> getAlbums() async {
    var box = await Hive.openBox<Album>(albumsBoxName);
    return box.values.toList();
  }
}
