import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocket_weather/model/city_forecast.dart';

class CityRepository {
  bool _isFetchingWorldCities = false;

  final StreamController<List<CityForecast>> _worldCitiesDataStreamController =
      StreamController<List<CityForecast>>.broadcast();

  Stream<List<CityForecast>> get worldCitiesDataStream =>
      _worldCitiesDataStreamController.stream;

  bool _isFetchingTaiwanCities = false;

  final StreamController<List<CityForecast>> _taiwanCitiesDataStreamController =
      StreamController<List<CityForecast>>.broadcast();

  Stream<List<CityForecast>> get taiwanCitiesDataStream =>
      _taiwanCitiesDataStreamController.stream;

  CityRepository._();

  static final CityRepository _instance = CityRepository._();

  factory CityRepository() {
    return _instance;
  }

  List<String> worldCities = ["London", "New York", "Tokyo", "Paris", "Berlin"];

  List<String> taiwanCities = [
    "25.0329694, 121.5654177", //台北
    "25.0169829, 121.4627868", //新北
    "24.9936285, 121.3009798", //桃園
    "24.163162, 120.647828", //台中
    "22.998601, 120.187817", //台南
    "22.6272784, 120.3014358", //高雄
    "25.0777633, 121.3646542", //林口
    "25.0375198, 121.4324464", //新莊
    "25.070049, 121.483442" //新莊
  ];

  Future<void> fetchWorldCities() async {
    if (!_isFetchingWorldCities) {
      _isFetchingWorldCities = true;
      List<Future<CityForecast>> futures = [];
      for (var i = 0; i < worldCities.length; i++) {
        final fullUrl =
            'https://api.weatherapi.com/v1/forecast.json?key=c2d28b91440d4393a78121230241402&q=${worldCities[i]}&days=7&aqi=no&alerts=no';
        futures.add(fetchApi(fullUrl));
      }
      try {
        List<CityForecast> results = await Future.wait(futures);
        print('$results');
        _worldCitiesDataStreamController.add(results);
      } catch (e) {
        print('Error fetching world cities: $e');
      } finally {
        _isFetchingWorldCities = false;
      }
    } else {
      print("Is Fetching (World City)");
    }
  }

  Future<void> fetchTaiwanCities() async {
    if (!_isFetchingTaiwanCities) {
      _isFetchingTaiwanCities = true;
      List<Future<CityForecast>> futures = [];
      for (var i = 0; i < taiwanCities.length; i++) {
        final fullUrl =
            'https://api.weatherapi.com/v1/forecast.json?key=c2d28b91440d4393a78121230241402&q=${taiwanCities[i]}&days=7&aqi=no&alerts=no';
        futures.add(fetchApi(fullUrl));
      }
      try {
        List<CityForecast> results = await Future.wait(futures);
        _taiwanCitiesDataStreamController.add(results);
      } catch (e) {
        print('Error fetching Taiwan cities: $e');
      } finally {
        _isFetchingTaiwanCities = false;
      }
    } else {
      print("Is Fetching (Taiwan)");
    }
  }

  Future<CityForecast> fetchApi(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      CityForecast forcast = CityForecast.fromJson(jsonResponse);
      return forcast;
    } else {
      throw Exception('Fail to load data from API ${response.statusCode}');
    }
  }

  void dispose() {
    print("call dispost of CityRepository");
  }
}
