import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:pocket_weather/model/day_condition.dart';

@JsonSerializable()
class Forecastday {
  final int dateEpoch;
  final DayCondition dayCondition;

  const Forecastday({required this.dateEpoch, required this.dayCondition});

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
      dateEpoch: json['date_epoch'] as int,
      dayCondition: DayCondition.fromJson(json['day']));

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'date_epoch': dateEpoch, 'day': dayCondition};
}

@JsonSerializable()
class Forecast {
  List<Forecastday> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var forecastdayList = json['forecastday'] as List;
    List<Forecastday> forecastday =
        forecastdayList.map((e) => Forecastday.fromJson(e)).toList();
    return Forecast(forecastday: forecastday);
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

  factory CityForecast.fromJson(Map<String, dynamic> json) => CityForecast(
      location: CityLocation.fromJson(json['location']),
      current: CityCurrent.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']));

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
        'forecast': forecast.toJson()
      };
}
