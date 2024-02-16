import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CityLocation {
  final String name;
  final double lat;
  final double lon;

  const CityLocation(
      {required this.name, required this.lat, required this.lon});

  factory CityLocation.fromJson(Map<String, dynamic> json) {
    final name = json.containsKey('name') ? json['name'] as String : '';
    final lat = json.containsKey('lat') ? json['lat'] as double : 0.0;
    final lon = json.containsKey('lon') ? json['lon'] as double : 0.0;

    return CityLocation(name: name, lat: lat, lon: lon);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'lat': lat, 'lon': lon};
}
