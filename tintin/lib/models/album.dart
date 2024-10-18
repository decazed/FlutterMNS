import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'gps.dart';

part 'album.g.dart';

@HiveType(typeId: 1)
class Album extends HiveObject {
  @HiveField(0)
  final int numero;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int year;

  @HiveField(3)
  final int? yearInColor;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String resume;

  @HiveField(6)
  final GPS gps;

  @HiveField(7)
  final String location;

  Album({
    required this.title,
    required this.numero,
    required this.year,
    this.yearInColor,
    required this.image,
    required this.resume,
    required this.gps,
    required this.location
  });

  @override
  String toString() {
    return 'Album(title: $title, numero: $numero, year: $year, yearInColor: $yearInColor, image: $image, resume: $resume, gps: $gps, location: $location)';
  }

  String toJson() {
    return jsonEncode({
      'title': title,
      'numero': numero,
      'year': year,
      'yearInColor': yearInColor,
      'image': image,
      'resume': resume,
      'gps': gps.toJson(),
      'location': location,
    });
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json['titre'],
      numero: json['numero'],
      year: json['parution'],
      yearInColor: json['parutionEnCouleur'],
      image: 'images/${json['image']}',
      resume: json['resume'],
      gps: GPS.fromJson(json),
      location: json['lieu']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'title': title,
      'year': year,
      'yearInColor': yearInColor,
      'image': image,
      'resume': resume,
      'latitude': gps.latitude,
      'longitude': gps.longitude,
      'location' : location,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      numero: map['numero'],
      title: map['title'],
      year: map['year'],
      yearInColor: map['yearInColor'],
      image: map['image'],
      resume: map['resume'],
      gps: GPS.fromMap(map),
      location: map['location'],
    );
  }
}