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

  factory CityCurrent.fromJson(Map<String, dynamic> json) => CityCurrent(
      lastUpdatedEpoch: json['last_updated_epoch'] as int,
      currentTemp: json['temp_c'] as double,
      condition: WeatherCondition.fromJson(json['condition']));

  Map<String, dynamic> toJson() => {
        'last_updated_epoch': lastUpdatedEpoch,
        'temp_c': currentTemp,
        'condition': condition.toJson()
      };
}
