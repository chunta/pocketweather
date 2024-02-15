import 'dart:async';
import 'package:pocket_weather/model/custom_location.dart';
import 'package:pocket_weather/model/custom_location_repository.dart';
import 'package:logger/logger.dart';

class CustomLocationViewModel {
  final logger = Logger();

  CustomLocationViewModel._();

  static final CustomLocationViewModel _instance = CustomLocationViewModel._();

  factory CustomLocationViewModel() {
    return _instance;
  }

  Future<bool> saveCustomLocation(double lat, double lon, String label) {
    return CustomLocationRepository().saveCustomLocation(lat, lon, label);
  }

  Future<Map<String, CustomLocation>> getAllCustomLocations() {
    return CustomLocationRepository().getAllCustomLocations();
  }

  void dispose() {
    logger.d("call dispost of CityViewModel");
  }
}
