import 'dart:convert';
import 'package:hive_flutter/adapters.dart';

part 'gps.g.dart';

@HiveType(typeId: 0)
class GPS {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  GPS({required this.latitude, required this.longitude});

  String toJson() {
    return jsonEncode({
      'latitude': latitude,
      'longitude': longitude
    });
  }

  factory GPS.fromJson(Map<String, dynamic> json) {
    String jsonGps = json['gps'];
    List<String> list = jsonGps.split(',');
    return GPS(
      latitude: double.parse(list[0]),
      longitude: double.parse(list[1])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GPS.fromMap(Map<String, dynamic> map) {
    return GPS(
      latitude: map['latitude'],
      longitude: map['longitude']
    );
  }
}