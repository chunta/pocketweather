import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_weather/model/weather_condition.dart';

@JsonSerializable()
class DayCondition {
  final double maxtemp;
  final double mintemp;
  final int avghumidity;
  final WeatherCondition condition;

  const DayCondition(
      this.maxtemp, this.mintemp, this.avghumidity, this.condition);

  DayCondition.fromJson(Map<String, dynamic> json)
      : maxtemp = json['maxtemp_c'] as double,
        mintemp = json['mintemp_c'] as double,
        avghumidity = json['avghumidity'] as int,
        condition = WeatherCondition.fromJson(json['condition']);

  Map<String, dynamic> toJson() => {
        'maxtemp': maxtemp,
        'mintemp': mintemp,
        'avghumidity': avghumidity,
        'condition': condition
      };
}
