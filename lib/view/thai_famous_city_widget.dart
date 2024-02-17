// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/model/weather_condition_table.dart';
import 'package:pocket_weather/utility.dart';
import 'package:pocket_weather/view_model/thai_famous_city_view_model.dart';
import 'package:provider/provider.dart';

class ThaiParentWidget extends StatelessWidget {
  const ThaiParentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("ThaiParentWidget build its body");
    return SafeArea(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0), // Add top margin
          child: const Text("Top Title"),
        ),
        const ThaiFamousCityButtonsWidget(),
        const Expanded(
          child: ThaiFamousCityWidget(),
        ),
        const Text("Bottom Title"),
      ],
    ));
  }
}

class ThaiFamousCityButtonsWidget extends StatelessWidget {
  const ThaiFamousCityButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d('ThaiFamousCityButtonsWidget build its body');
    return Column(children: [
      const SizedBox(height: 20), // Added SizedBox for spacing
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              ThaiFamousCityViewModel()
                  .fetchForcastByNameCase(ThaiFamousCity.bangkok);
            },
            child: Text(ThaiFamousCityViewModel()
                .nameFromNameCity(ThaiFamousCity.bangkok)),
          ),
          ElevatedButton(
            onPressed: () {
              ThaiFamousCityViewModel()
                  .fetchForcastByNameCase(ThaiFamousCity.chiangMai);
            },
            child: Text(ThaiFamousCityViewModel()
                .nameFromNameCity(ThaiFamousCity.chiangMai)),
          ),
          ElevatedButton(
            onPressed: () {
              ThaiFamousCityViewModel()
                  .fetchForcastByNameCase(ThaiFamousCity.phuket);
            },
            child: Text(ThaiFamousCityViewModel()
                .nameFromNameCity(ThaiFamousCity.phuket)),
          ),
        ],
      ),
    ]);
  }
}

class ThaiFamousCityWidget extends StatelessWidget {
  const ThaiFamousCityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d('ThaiFamousCityWidget build its body');
    return ChangeNotifierProvider(
      create: (_) => ThaiFamousCityViewModel(),
      child: ThaiFamousCityBodyWidget(
          conditionManager: WeatherConditionManager(
        conditionTable: WeatherConditionTable(),
      )),
    );
  }
}

class ThaiFamousCityBodyWidget extends StatelessWidget {
  final WeatherConditionManager conditionManager;

  ThaiFamousCityBodyWidget({super.key, required this.conditionManager});

  bool inited = false;

  @override
  Widget build(BuildContext context) {
    Logger().d('ThaiFamousCityBodyWidget build its body');
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (context
              .watch<ThaiFamousCityViewModel>()
              .cityForecast
              .location
              .name
              .isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0), // Adjust top margin as needed
              child: Text(
                context
                    .watch<ThaiFamousCityViewModel>()
                    .cityForecast
                    .location
                    .name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: Consumer<ThaiFamousCityViewModel>(
              builder: (context, thaiCityViewModel, _) {
                if (!inited) {
                  conditionManager.initTable();
                  thaiCityViewModel
                      .fetchForcastByNameCase(ThaiFamousCity.bangkok);
                  inited = true;
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: thaiCityViewModel
                      .cityForecast.forecast.forecastday.length,
                  itemBuilder: (context, index) {
                    final dayForecast = thaiCityViewModel
                        .cityForecast.forecast.forecastday[index];
                    return ListTile(
                      title:
                          Text(Utility.formatEpochTime(dayForecast.dateEpoch)),
                      subtitle: Text(conditionManager.lookUpDescriptionByCode(
                          dayForecast.dayCondition.condition.code)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
