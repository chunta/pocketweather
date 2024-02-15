import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class City {
  final CityLocation location;
  final CityCurrent weather;

  const City({required this.location, required this.weather});

  factory City.fromJson(Map<String, dynamic> json) => City(
      location: CityLocation.fromJson(json['location']),
      weather: CityCurrent.fromJson(json['current']));

  Map<String, dynamic> toJson() =>
      {'location': location.toJson(), 'weather': weather.toJson()};
}
