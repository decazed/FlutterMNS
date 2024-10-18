import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:tintin/models/album.dart';
import 'package:tintin/models/gps.dart';
import 'package:flutter/services.dart';

class AlbumService {
  static Future<List<Album>> generateAlbums() async {
    final faker = Faker();
    final List<String> imagesPaths = [
      'images/coke-en-stock.jpg',
      'images/l-affaire-tournesol.jpg',
      'images/l-etoile-mysterieuse.jpg',
      'images/l-ile-noire.jpg',
      'images/l-oreile-cassee.jpg',
      'images/le-crabe-aux-pinces-d-or.jpg',
      'images/le-lotus-bleu.jpg',
      'images/le-sceptre-d-ottokar.jpg',
      'images/le-secret-de-la-licorne.jpg',
      'images/le-temple-du-soleil.jpg',
      'images/le-tresor-de-rackham-le-rouge.jpg',
      'images/les-7-boules-de-cristal.jpg',
      'images/les-cigares-du-pharaon.jpg',
      'images/objectif-lune.jpg',
      'images/on-a-marche-sur-la-lune.jpg',
      'images/tintin-au-congo.jpg',
      'images/tintin-au-pays-de-l-or-noir.jpg',
      'images/tintin-au-pays-des-soviets.jpg',
      'images/tintin-au-tibet.jpg',
      'images/tintin-en-amerique.jpg',
      'images/tintin-et-l-alph-art.jpg',
      'images/tintin-et-les-picaros.jpg',
      'images/vol-714-pour-sydney.jpg',
      'images/les-bijoux-de-la-castafiore.jpg'
    ];
    return List<Album>.generate(30, (index) {
      final title = faker.lorem.sentence();
      final numero = faker.randomGenerator.integer(100);
      final year = faker.randomGenerator.integer(57) + 1929;
      final yearInColor = faker.randomGenerator.boolean() ? faker
          .randomGenerator.integer(57) + 1929 : null;
      String image = '';
      if (imagesPaths.isNotEmpty) {
        int i = faker.randomGenerator.integer(imagesPaths.length);
        image = imagesPaths[i];
        imagesPaths.removeAt(i);
      }
      final resume = faker.lorem.words(faker.randomGenerator.integer(100))
          .toString()
          .replaceAll(RegExp(r'[\[\],]'), '');
      final gps = GPS(latitude: faker.randomGenerator.decimal(scale: 180) - 90,
          longitude: faker.randomGenerator.decimal(scale: 360) - 180);
      final location = faker.address.city();
      return Album(title: title,
          numero: numero,
          year: year,
          yearInColor: yearInColor,
          image: image,
          resume: resume,
          gps: gps,
          location: location);
    });
  }

  static Future<List<Album>> fetchAlbums() async {
    final String jsonString = await rootBundle.loadString('data/albums.json');
    final List<dynamic> data = jsonDecode(jsonString);
    return data.map((albumJson) => Album.fromJson(albumJson)).toList();
  }
}