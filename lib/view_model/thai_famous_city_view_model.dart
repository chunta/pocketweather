import 'dart:async';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';

class ThaiFamousCityViewModel {
  final logger = Logger();

  ThaiFamousCityViewModel._();

  static final ThaiFamousCityViewModel _instance = ThaiFamousCityViewModel._();

  factory ThaiFamousCityViewModel() {
    return _instance;
  }

  Future<CityForecast> fetchForcastByNameCase(ThaiFamousCity nameCase) async {
    return ThaiFamousCityRepository().fetchThaiCityByNameCase(nameCase);
  }

  String nameFromNameCity(ThaiFamousCity nameCase) {
    return ThaiFamousCityRepository().nameFromNameCity(nameCase);
  }

  void dispose() {
    logger.d("call dispost of CityViewModel");
  }
}
