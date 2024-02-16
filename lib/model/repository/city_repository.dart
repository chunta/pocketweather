import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/city.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/weather_condition.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio/dio.dart';

class CityRepository {
  final logger = Logger();

  static const String _apiKey = '96d64ec5a2ec46d99bd71813241602';
  static const String _apiBaseUrl =
      'https://api.weatherapi.com/v1/forecast.json';
  static const String _queryParams = 'days=7&aqi=no&alerts=no';

  bool _isFetchingWorldCities = false;
  bool _isFetchingTaiwanCities = false;

  final StreamController<List<CityForecast>> _worldCitiesDataStreamController =
      StreamController<List<CityForecast>>.broadcast();

  final StreamController<List<CityForecast>> _taiwanCitiesDataStreamController =
      StreamController<List<CityForecast>>.broadcast();

  // ignore: unused_field
  List<CityForecast> _worldCitiesValue = [];
  // ignore: unused_field
  List<CityForecast> _taiwanCitiesValue = [];

  Stream<List<CityForecast>> get worldCitiesDataStream =>
      _worldCitiesDataStreamController.stream;

  Stream<List<CityForecast>> get taiwanCitiesDataStream =>
      _taiwanCitiesDataStreamController.stream;

  CityRepository._();

  static final CityRepository _instance = CityRepository._();

  static late Dio dio;

  factory CityRepository() {
// Global options
    final options = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.forceCache,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403, 304],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
     dio = Dio()
      ..interceptors.add(
        DioCacheInterceptor(options: options),
      );

    return _instance;
  }

  List<String> worldCities = ["London", "New York", "Tokyo", "Paris", "Berlin"];

  List<String> taiwanCities = [
    "Taipei",
    "Panchiao",
    "Chungho",
    "Taoyuan",
    "Taichung",
    "Tainan",
    "Kaohsiung",
    "Hualien",
    "Taitung",
  ];

  Future<void> fetchWorldCities() async {
    if (!_isFetchingWorldCities) {
      _isFetchingWorldCities = true;
      List<Future<CityForecast>> futures = [];
      for (var city in worldCities) {
        final fullUrl = '$_apiBaseUrl?key=$_apiKey&q=$city&$_queryParams';
        futures.add(fetchApi(fullUrl));
      }
      try {
        logger.d('(72) has world cities');
        List<CityForecast> results = await Future.wait(futures);
        _worldCitiesValue = results;
        _worldCitiesDataStreamController.add(results);
      } catch (e) {
        logger.d('(77) Error fetching world cities: $e');
        _worldCitiesDataStreamController.addError(e);
      } finally {
        _isFetchingWorldCities = false;
      }
    } else {
      logger.d("Is Fetching (World City)");
    }
  }

  Future<void> fetchTaiwanCities() async {
    if (!_isFetchingTaiwanCities) {
      _isFetchingTaiwanCities = true;
      List<Future<CityForecast>> futures = [];
      for (var city in taiwanCities) {
        final fullUrl = '$_apiBaseUrl?key=$_apiKey&q=$city&$_queryParams';
        futures.add(fetchApi(fullUrl));
      }
      try {
        logger.d('(96) has taiwan cities');
        List<CityForecast> results = await Future.wait(futures);
        _taiwanCitiesValue = results;
        _taiwanCitiesDataStreamController.add(results);
      } catch (e) {
        logger.d('Error fetching Taiwan cities: $e');
        _taiwanCitiesDataStreamController.addError(e);
      } finally {
        _isFetchingTaiwanCities = false;
      }
    } else {
      logger.d("Is Fetching (Taiwan)");
    }
  }

  Future<CityForecast> fetchForcastByName(String name) async {
    for (var forecast in _worldCitiesValue) {
      if (forecast.location.name == name) {
        return forecast;
      }
    }
    for (var forecast in _taiwanCitiesValue) {
      if (forecast.location.name == name) {
        return forecast;
      }
    }
    final fullUrl = '$_apiBaseUrl?key=$_apiKey&q=$name&$_queryParams';
    return fetchApi(fullUrl);
  }

  Future<CityForecast> fetchForcastByLatLon(double lat, double lon) async {
    final fullUrl = '$_apiBaseUrl?key=$_apiKey&q=$lat,$lon&$_queryParams';
    return fetchApi(fullUrl);
  }

  Future<CityForecast> fetchApi(String url) async {
    try {
      //
      dio.options.headers.remove('If-None-Match');
      var fresponse = await dio.get("http://localhost:3000/test");
      logger.d(fresponse.statusCode);
      logger.d(fresponse.headers);
      logger.d(fresponse.data);
      dio.options.headers = {'If-None-Match': fresponse.headers['etag']};
      fresponse = await dio.get("http://localhost:3000/test");
      logger.d(fresponse.statusCode);
      logger.d(fresponse.data);
      //
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

  void dispose() {
    logger.d("call dispost of CityRepository");
  }
}
