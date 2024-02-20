import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/view_model/thai_city_view_model.dart';

class ThaiFamousCityViewModel with ChangeNotifier implements ThaiCityViewModel {
  final logger = Logger();

  @override
  CityForecast cityForecast = CityForecast.fromJson({});

  ThaiFamousCityViewModel._();

  static final ThaiFamousCityViewModel _instance = ThaiFamousCityViewModel._();

  factory ThaiFamousCityViewModel() {
    return _instance;
  }

  @override
  Future<void> fetchForcastByNameCase(ThaiFamousCity nameCase) async {
    cityForecast =
        await ThaiFamousCityRepository().fetchThaiCityByNameCase(nameCase);
    notifyListeners();
  }

  @override
  String nameFromNameCity(ThaiFamousCity nameCase) {
    return ThaiFamousCityRepository().nameFromNameCity(nameCase);
  }
}
