import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_weather/model/city_forecast_day.dart';
import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/city_current.dart';

@JsonSerializable()
class Forecast {
  List<Forecastday> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('forecastday')) {
      return Forecast(forecastday: []);
    }
    if (json['forecastday'] is List) {
      var forecastdayList = json['forecastday'] as List;
      List<Forecastday> forecastday =
          forecastdayList.map((e) => Forecastday.fromJson(e)).toList();
      return Forecast(forecastday: forecastday);
    } else {
      return Forecast(forecastday: []);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'forecastday': forecastday.map((e) => e.toJson()).toList(),
      };
}

@JsonSerializable()
class CityForecast {
  final CityLocation location;
  final CityCurrent current;
  final Forecast forecast;

  const CityForecast(
      {required this.location, required this.current, required this.forecast});

  factory CityForecast.fromJson(Map<String, dynamic> json) {
    final location = json.containsKey('location')
        ? CityLocation.fromJson(json['location'])
        : CityLocation.fromJson({});
    final current = json.containsKey('current')
        ? CityCurrent.fromJson(json['current'])
        : CityCurrent.fromJson({});
    final forecast = json.containsKey('forecast')
        ? Forecast.fromJson(json['forecast'])
        : Forecast(forecastday: []);

    return CityForecast(
        location: location, current: current, forecast: forecast);
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
        'forecast': forecast.toJson()
      };
}
