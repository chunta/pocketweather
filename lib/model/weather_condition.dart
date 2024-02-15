import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherCondition {
  final int code;

  WeatherCondition({required this.code});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      WeatherCondition(code: json['code'] as int);

  Map<String, dynamic> toJson() => {'code': code};
}
