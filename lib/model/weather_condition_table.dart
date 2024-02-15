import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

@JsonSerializable()
class WeatherConditionLanguage {
  final String lang_name;
  final String day_text;

  WeatherConditionLanguage({required this.lang_name, required this.day_text});

  factory WeatherConditionLanguage.fromJson(Map<String, dynamic> json) =>
      WeatherConditionLanguage(
          lang_name: json['lang_name'] as String,
          day_text: json['day_text'] as String);

  Map<String, dynamic> toJson() =>
      {'lang_name': lang_name, 'day_text': day_text};
}

@JsonSerializable()
class WeatherConditionMap {
  final int code;
  final String day;
  final List<WeatherConditionLanguage> languages;

  WeatherConditionMap(
      {required this.code, required this.day, required this.languages});

  factory WeatherConditionMap.fromJson(Map<String, dynamic> json) =>
      WeatherConditionMap(
        code: json['code'] as int,
        day: json['day'] as String,
        languages: (json['languages'] as List<dynamic>)
            .map((langJson) => WeatherConditionLanguage.fromJson(langJson))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'day': day,
        'language': languages.map((lang) => lang.toJson()).toList(),
      };

  String getDayText() {
    for (var lang in languages) {
      if (lang.lang_name == "Chinese Traditional") {
        return lang.day_text;
      }
    }
    return "";
  }
}

@JsonSerializable()
class WeatherConditionList {
  final List<WeatherConditionMap> conditionMap;

  WeatherConditionList({required this.conditionMap});

  factory WeatherConditionList.fromJson(List<dynamic> json) {
    List<WeatherConditionMap> maps = [];
    for (var item in json) {
      if (item is Map<String, dynamic>) {
        maps.add(WeatherConditionMap.fromJson(item));
      }
    }
    return WeatherConditionList(conditionMap: maps);
  }

  List<Map<String, dynamic>> toJson() =>
      conditionMap.map((condition) => condition.toJson()).toList();
}

class WeatherConditionTable {
  final logger = Logger();

  WeatherConditionList conditionList = WeatherConditionList.fromJson([]);

  WeatherConditionTable();

  Future<void> loadFromFile(String fileName) async {
    String jsonString = await rootBundle.loadString(fileName);
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> jsonMapList = [];
    for (var jsonItem in jsonList) {
      if (jsonItem is Map<String, dynamic>) {
        jsonMapList.add(jsonItem);
      }
    }
    conditionList = WeatherConditionList.fromJson(jsonMapList);
  }

  String lookUpDescriptionByCode(int code) {
    for (var condition in conditionList.conditionMap) {
      if (condition.code == code) {
        return condition.getDayText();
      }
    }
    return "";
  }
}

class WeatherConditionManager {
  final WeatherConditionTable conditionTable;

  WeatherConditionManager({required this.conditionTable});

  Future<void> initTable() async {
    await conditionTable.loadFromFile('assets/conditions.json');
  }

  String lookUpDescriptionByCode(int code) {
    return conditionTable.lookUpDescriptionByCode(code);
  }
}
