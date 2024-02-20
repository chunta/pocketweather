// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/model/weather_condition_table.dart';
import 'package:pocket_weather/utility.dart';
import 'package:pocket_weather/view_model/thai_city_view_model.dart';
import 'package:provider/provider.dart';

class ThaiParentWidget extends StatelessWidget {
  final ThaiCityViewModel viewModel;
  const ThaiParentWidget({super.key, required this.viewModel});

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
        ThaiFamousCityButtonsWidget(
          viewModel: viewModel,
        ),
        Expanded(
          child: ThaiFamousCityWidget(
            viewModel: viewModel,
          ),
        ),
        const Text("Bottom Title"),
      ],
    ));
  }
}

class ThaiFamousCityButtonsWidget extends StatelessWidget {
  final ThaiCityViewModel viewModel;
  const ThaiFamousCityButtonsWidget({super.key, required this.viewModel});

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
              viewModel.fetchForcastByNameCase(ThaiFamousCity.bangkok);
            },
            child: Text(viewModel.nameFromNameCity(ThaiFamousCity.bangkok)),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.fetchForcastByNameCase(ThaiFamousCity.chiangMai);
            },
            child: Text(viewModel.nameFromNameCity(ThaiFamousCity.chiangMai)),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.fetchForcastByNameCase(ThaiFamousCity.phuket);
            },
            child: Text(viewModel.nameFromNameCity(ThaiFamousCity.phuket)),
          ),
        ],
      ),
    ]);
  }
}

class ThaiFamousCityWidget extends StatelessWidget {
  final ThaiCityViewModel viewModel;
  const ThaiFamousCityWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    Logger().d('ThaiFamousCityWidget build its body');
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: ThaiFamousCityBodyWidget(
          conditionManager:
              WeatherConditionManager(conditionTable: WeatherConditionTable())),
    );
  }
}

class ThaiFamousCityBodyWidget extends StatelessWidget {
  final WeatherConditionManager conditionManager;
  ThaiFamousCityBodyWidget({super.key, required this.conditionManager});

  bool inited = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    Logger().d('ThaiFamousCityBodyWidget build its body ${count++}');
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (context
              .watch<ThaiCityViewModel>()
              .cityForecast
              .location
              .name
              .isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0), // Adjust top margin as needed
              child: Text(
                context.watch<ThaiCityViewModel>().cityForecast.location.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: Consumer<ThaiCityViewModel>(
              builder: (context, thaiCityViewModel, _) {
                if (!inited) {
                  conditionManager.initTable();
                  thaiCityViewModel
                      .fetchForcastByNameCase(ThaiFamousCity.bangkok);
                  inited = true;
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  key: const Key("TheListViewICare"),
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
