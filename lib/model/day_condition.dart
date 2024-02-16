import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_weather/model/weather_condition.dart';

@JsonSerializable()
class DayCondition {
  final double maxtemp;
  final double mintemp;
  final int avghumidity;
  final WeatherCondition condition;

  const DayCondition(
      {required this.maxtemp,
      required this.mintemp,
      required this.avghumidity,
      required this.condition});

  factory DayCondition.fromJson(Map<String, dynamic> json) {
    final maxtemp =
        json.containsKey('maxtemp') ? json['maxtemp'] as double : 0.0;
    final mintemp =
        json.containsKey('mintemp') ? json['mintemp'] as double : 0.0;
    final avghumidity =
        json.containsKey('avghumidity') ? json['avghumidity'] as int : 0;
    final condition = json.containsKey('condition')
        ? WeatherCondition.fromJson(json['condition'])
        : WeatherCondition.fromJson({});

    return DayCondition(
        maxtemp: maxtemp,
        mintemp: mintemp,
        avghumidity: avghumidity,
        condition: condition);
  }

  Map<String, dynamic> toJson() => {
        'maxtemp': maxtemp,
        'mintemp': mintemp,
        'avghumidity': avghumidity,
        'condition': condition
      };
}
