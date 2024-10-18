import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tintin/providers/reading_list_provider.dart';
import 'package:tintin/screens/album_master.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/models/gps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GPSAdapter());
  Hive.registerAdapter(AlbumAdapter());

  runApp(
      ChangeNotifierProvider(
        create: (context) => ReadingListProvider(),
        child: const AlbumMaster(),
      )
  );
}
