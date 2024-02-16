import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_weather/model/day_condition.dart';

@JsonSerializable()
class Forecastday {
  final int dateEpoch;
  final DayCondition dayCondition;

  const Forecastday({required this.dateEpoch, required this.dayCondition});

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    final dateEpoch =
        json.containsKey('date_epoch') ? json['date_epoch'] as int : 0;
    final dayCondition = json.containsKey('day')
        ? DayCondition.fromJson(json['day'])
        : DayCondition.fromJson({});

    return Forecastday(dateEpoch: dateEpoch, dayCondition: dayCondition);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'date_epoch': dateEpoch, 'day': dayCondition};
}
