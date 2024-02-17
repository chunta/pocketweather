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
    print("(14)");
    return SafeArea(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0), // Add top margin
          child: const Text("line 18"),
        ),
        const Expanded(
          child: ThaiFamousCityWidget(),
        ),
        const Text("line 18"),
      ],
    ));
  }
}

class ThaiFamousCityWidget extends StatelessWidget {
  const ThaiFamousCityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThaiFamousCityViewModel(),
      child: ThaiFamousCityBodyWidget(
        conditionManager:
            WeatherConditionManager(conditionTable: WeatherConditionTable()),
      ),
    );
  }
}

class ThaiFamousCityBodyWidget extends StatelessWidget {
  final logger = Logger();

  final WeatherConditionManager conditionManager;

  ThaiFamousCityBodyWidget({super.key, required this.conditionManager});

  // bool inited = false;

  @override
  Widget build(BuildContext context) {
    print('build 35');
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20), // Added SizedBox for spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ThaiFamousCityViewModel>()
                      .fetchForcastByNameCase(ThaiFamousCity.bangkok);
                },
                child: Text(context
                    .watch<ThaiFamousCityViewModel>()
                    .nameFromNameCity(ThaiFamousCity.bangkok)),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ThaiFamousCityViewModel>()
                      .fetchForcastByNameCase(ThaiFamousCity.chiangMai);
                },
                child: Text(context
                    .watch<ThaiFamousCityViewModel>()
                    .nameFromNameCity(ThaiFamousCity.chiangMai)),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ThaiFamousCityViewModel>()
                      .fetchForcastByNameCase(ThaiFamousCity.phuket);
                },
                child: Text(context
                    .watch<ThaiFamousCityViewModel>()
                    .nameFromNameCity(ThaiFamousCity.phuket)),
              ),
            ],
          ),
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
                // if (!inited) {
                //   conditionManager.initTable();
                //   thaiCityViewModel.fetchForcastByNameCase(ThaiFamousCity.bangkok);
                //   inited = true;
                //   return const Center(child: CircularProgressIndicator());
                // }
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

/*
class ThaiFamousCityBodyWidget extends StatelessWidget {
  final logger = Logger();

  final WeatherConditionManager conditionManager;

  ThaiFamousCityBodyWidget({super.key, required this.conditionManager});

  bool inited = false;

  @override
  Widget build(BuildContext context) {
    
    return Consumer<ThaiFamousCityViewModel>(
        builder: (context, thaiCityViewModel, _) {
      print("(38)");
      if (inited == false) {
        conditionManager.initTable();
        thaiCityViewModel.fetchForcastByNameCase(ThaiFamousCity.bangkok);
        inited = true;
         return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20), // Added SizedBox for spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    thaiCityViewModel
                        .fetchForcastByNameCase(ThaiFamousCity.bangkok);
                  },
                  child: Text(thaiCityViewModel
                      .nameFromNameCity(ThaiFamousCity.bangkok)),
                ),
                ElevatedButton(
                  onPressed: () {
                    thaiCityViewModel
                        .fetchForcastByNameCase(ThaiFamousCity.chiangMai);
                  },
                  child: Text(thaiCityViewModel
                      .nameFromNameCity(ThaiFamousCity.chiangMai)),
                ),
                ElevatedButton(
                  onPressed: () {
                    thaiCityViewModel
                        .fetchForcastByNameCase(ThaiFamousCity.phuket);
                  },
                  child: Text(thaiCityViewModel
                      .nameFromNameCity(ThaiFamousCity.phuket)),
                ),
              ],
            ),
            if (thaiCityViewModel.cityForecast.location.name.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Adjust top margin as needed
                child: Text(
                  thaiCityViewModel.cityForecast.location.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    thaiCityViewModel.cityForecast.forecast.forecastday.length,
                itemBuilder: (context, index) {
                  final dayForecast = thaiCityViewModel
                      .cityForecast.forecast.forecastday[index];
                  return ListTile(
                    title: Text(Utility.formatEpochTime(dayForecast.dateEpoch)),
                    subtitle: Text(conditionManager.lookUpDescriptionByCode(
                        dayForecast.dayCondition.condition.code)),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
*/
