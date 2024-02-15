import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustomLocation {
  final double lat;
  final double lon;
  final String label;

  const CustomLocation(
      {required this.lat, required this.lon, required this.label});

  factory CustomLocation.fromJson(Map<String, dynamic> json) => CustomLocation(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      label: json['label'] as String);

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon, 'label': label};
}
