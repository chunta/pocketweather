import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class City {
  final CityLocation location;
  final CityCurrent weather;

  const City({required this.location, required this.weather});

  factory City.fromJson(Map<String, dynamic> json) {
    final location = json.containsKey('location')
        ? CityLocation.fromJson(json['location'])
        : CityLocation.fromJson({});
    final weather = json.containsKey('current')
        ? CityCurrent.fromJson(json['current'])
        : CityCurrent.fromJson({});

    return City(location: location, weather: weather);
  }

  Map<String, dynamic> toJson() =>
      {'location': location.toJson(), 'weather': weather.toJson()};
}
