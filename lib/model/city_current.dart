import 'weather_condition.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CityCurrent {
  final int lastUpdatedEpoch;
  final double currentTemp;
  final WeatherCondition condition;

  const CityCurrent(
      {required this.lastUpdatedEpoch,
      required this.currentTemp,
      required this.condition});

  factory CityCurrent.fromJson(Map<String, dynamic> json) {
    final lastUpdatedEpoch = json.containsKey('last_updated_epoch')
        ? json['last_updated_epoch'] as int
        : 0;
    final currentTemp =
        json.containsKey('temp_c') ? json['temp_c'] as double : 0.0;
    final condition = json.containsKey('condition')
        ? WeatherCondition.fromJson(json['condition'])
        : WeatherCondition.fromJson({});

    return CityCurrent(
        lastUpdatedEpoch: lastUpdatedEpoch,
        currentTemp: currentTemp,
        condition: condition);
  }

  Map<String, dynamic> toJson() => {
        'last_updated_epoch': lastUpdatedEpoch,
        'temp_c': currentTemp,
        'condition': condition.toJson()
      };
}
