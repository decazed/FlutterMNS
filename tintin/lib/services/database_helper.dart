import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/album.dart';

class DatabaseHelper {
  static final _databaseName = "albums.db";
  static final _databaseVersion = 1;
  static final table = 'albums';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print('Database path: $path');
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $table (
            numero INTEGER PRIMARY KEY,
            title TEXT,
            year INTEGER,
            yearInColor INTEGER,
            image TEXT,
            resume TEXT,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
    );
  }

  Future<void> insertAlbum(Album album) async {
    final db = await instance.database;
    await db.insert(table, album.toMap());
  }

  Future<void> deleteAlbum(int numero) async {
    final db = await instance.database;
    await db.delete(table, where: 'numero = ?', whereArgs: [numero]);
  }

  Future<List<Album>> getAlbums() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Album.fromJson(maps[i]);
    });
  }
}