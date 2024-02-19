import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';

abstract class ThaiCityViewModel with ChangeNotifier {
  Future<void> fetchForcastByNameCase(ThaiFamousCity city);
  String nameFromNameCity(ThaiFamousCity city);
  CityForecast get cityForecast;
}
