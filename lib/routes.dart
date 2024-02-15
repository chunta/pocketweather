import 'package:flutter/material.dart';
import 'package:pocket_weather/main.dart';
import 'package:pocket_weather/model/weather_condition_table.dart';
import 'package:pocket_weather/view/city_forcast_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class Routers {
  static String root = "/";
  static String cityForcast = '/city_forcast';

  static final routers = {
    root: (context) => const HomePage(),
    cityForcast: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return CityForecastWidget(
          conditionManager:
              WeatherConditionManager(conditionTable: WeatherConditionTable()),
          cityViewModel: CityViewModel(),
          name: args['name'] as String? ?? "",
          lat: args['lat'] as double? ?? 0.0,
          lon: args['lon'] as double? ?? 0.0);
    }
  };
}
