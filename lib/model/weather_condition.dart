import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherCondition {
  final int code;

  WeatherCondition({required this.code});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    final code = json.containsKey('code') ? json['code'] as int : 0;
    return WeatherCondition(code: code);
  }

  Map<String, dynamic> toJson() => {'code': code};
}
