import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/city_forecast_day.dart';
import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/day_condition.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/model/weather_condition.dart';
import 'package:pocket_weather/view_model/thai_city_view_model.dart';

class ThaiViewModelMock with ChangeNotifier implements ThaiCityViewModel {

  String title = "mock00";

  int numberOfForecastDay = 1;

  @override
  CityForecast cityForecast = CityForecast.fromJson({});

  ThaiViewModelMock._();

  static final ThaiViewModelMock _instance = ThaiViewModelMock._();

  factory ThaiViewModelMock() {
    return _instance;
  }

  @override
  Future<void> fetchForcastByNameCase(ThaiFamousCity city) async {
    await Future.delayed(const Duration(seconds: 1));
    final mockCurrentCondition = WeatherCondition.fromJson({'code': 100});
    final mockCurrent = CityCurrent(condition: mockCurrentCondition, currentTemp: 10, lastUpdatedEpoch: 100);
    final mockLocation = CityLocation.fromJson({'name': title, 'lat': 1.0, 'lon': 2.0});
    List<Forecastday> days = [];
    for (var i = 0; i < numberOfForecastDay; i++) {
      final dayCondition = WeatherCondition.fromJson({'code': 10});
      final mockForcastdays = Forecastday(dateEpoch: 0, dayCondition: DayCondition(avghumidity: 0, maxtemp: 10.2, mintemp: 0.0, condition: dayCondition));
      days.add(mockForcastdays);
    }
    final mockForcast = Forecast(forecastday: days);
    cityForecast = CityForecast(current: mockCurrent, location: mockLocation, forecast: mockForcast);
    notifyListeners();
  }

  @override
  String nameFromNameCity(ThaiFamousCity city) {
    return "TmpNotUsed";
  }
}