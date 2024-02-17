import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/repository/weather_api.dart';

enum ThaiFamousCity {
  bangkok,
  chiangMai,
  phuket,
}

class ThaiFamousCityRepository {
  final logger = Logger();

  static const String _apiKey = WEATHER_API_KEY;
  static const String _apiBaseUrl = WEATHER_BASE_URL;
  static const String _queryParams = 'days=7&aqi=no&alerts=no';

  final StreamController<List<CityForecast>> _thaiCitiesDataStreamController =
      StreamController<List<CityForecast>>.broadcast();

  Stream<List<CityForecast>> get thaiCitiesDataStream =>
      _thaiCitiesDataStreamController.stream;

  ThaiFamousCityRepository._();

  static final ThaiFamousCityRepository _instance =
      ThaiFamousCityRepository._();

  factory ThaiFamousCityRepository() {
    return _instance;
  }

  static final thaiCities = {
    ThaiFamousCity.bangkok: "Bangkok",
    ThaiFamousCity.chiangMai: "Chiang Mai",
    ThaiFamousCity.phuket: "Phuket"
  };

  String nameFromNameCity(ThaiFamousCity nameCase) {
    return thaiCities[nameCase]!;
  }

  Future<CityForecast> fetchThaiCityByNameCase(ThaiFamousCity nameCase) async {
    String name = thaiCities[nameCase]!;
    final fullUrl = '$_apiBaseUrl?key=$_apiKey&q=$name&$_queryParams';
    return fetchApi(fullUrl);
  }

  Future<CityForecast> fetchApi(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return CityForecast.fromJson(jsonResponse);
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception('${e}');
    }
  }
}
