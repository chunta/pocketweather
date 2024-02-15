import 'dart:async';
import 'dart:convert';
import 'package:pocket_weather/model/custom_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class CustomLocationRepository {
  final logger = Logger();
  static const String customKey = 'pocket_custom_location';

  Future<Map<String, dynamic>> getCustomLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(customKey);
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return jsonMap;
    } else {
      return Future.value({});
    }
  }

  Future<bool> saveCustomLocation(double lat, double lon, String label) async {
    if (label.isEmpty) {
      return Future.value(false);
    }
    Map<String, dynamic> existingMap = await getCustomLocations();
    CustomLocation customLocation =
        CustomLocation(lat: lat, lon: lon, label: label);
    final jsonString = jsonEncode(customLocation.toJson());
    existingMap[label] = jsonString;
    final pref = await SharedPreferences.getInstance();
    return pref.setString(customKey, jsonEncode(existingMap));
  }

  Future<Map<String, CustomLocation>> getAllCustomLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(customKey);
    Map<String, CustomLocation> results = {};
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      jsonMap.forEach((key, value) {
        final customLocation = CustomLocation.fromJson(jsonDecode(value));
        results[key] = customLocation;
      });
      return Future.value(results);
    } else {
      return Future.value({});
    }
  }
}
