import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DayCondition {
  final double maxtemp;
  final double mintemp;
  final int avghumidity;

  const DayCondition(this.maxtemp, this.mintemp, this.avghumidity);

  DayCondition.fromJson(Map<String, dynamic> json)
      : maxtemp = json['maxtemp_c'] as double,
        mintemp = json['mintemp_c'] as double,
        avghumidity = json['avghumidity'] as int;

  Map<String, dynamic> toJson() =>
      {'maxtemp': maxtemp, 'mintemp': mintemp, 'avghumidity': avghumidity};
}
