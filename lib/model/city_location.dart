import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CityLocation {
  final String name;
  final double lat;
  final double lon;

  const CityLocation(
      {required this.name, required this.lat, required this.lon});

  factory CityLocation.fromJson(Map<String, dynamic> json) => CityLocation(
      name: json['name'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'lat': lat, 'lon': lon};
}
