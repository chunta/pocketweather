import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/weather_condition_table.dart';
import 'package:pocket_weather/utility.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class CityForecastWidget extends StatelessWidget {
  final CityViewModel cityViewModel;
  final String name;
  final double lat;
  final double lon;
  final WeatherConditionManager conditionManager;
  const CityForecastWidget(
      {super.key,
      required this.cityViewModel,
      required this.name,
      required this.lat,
      required this.lon,
      required this.conditionManager});

  @override
  Widget build(BuildContext context) {
    Future<CityForecast> fetchData() async {
      await conditionManager.initTable();
      if (name.isNotEmpty) {
        return cityViewModel.fetchForcastByName(name);
      } else if (lat != 0 && lon != 0) {
        return cityViewModel.fetchForcastByLatLon(lat, lon);
      }
      return CityForecast.fromJson({});
    }

    Widget getTitle() {
      if (name.isNotEmpty) {
        return FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('7 days forecast -  $name',
                style: const TextStyle(fontSize: 16)));
      } else if (lat != 0 && lon != 0) {
        return FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('7 days forecast -  at lat: $lat lon: $lon',
                style: const TextStyle(fontSize: 16)));
      }
      return const Text('City Forecast');
    }

    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<CityForecast>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text('${snapshot.error}',
                              style: const TextStyle(fontSize: 18)))));
            } else {
              final cityForecast = snapshot.data!;
              return ListView.builder(
                itemCount: cityForecast.forecast.forecastday.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(Utility.formatEpochTime(
                        cityForecast.forecast.forecastday[index].dateEpoch)),
                    subtitle: Text(conditionManager.lookUpDescriptionByCode(
                        cityForecast.forecast.forecastday[index].dayCondition
                            .condition.code)),
                  );
                },
              );
            }
          }),
    );
  }
}
