import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/utility.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class CityForecastWidget extends StatelessWidget {
  final CityViewModel cityViewModel;
  final String name;
  final double lat;
  final double lon;
  const CityForecastWidget(
      {super.key,
      required this.cityViewModel,
      required this.name,
      required this.lat,
      required this.lon});

  @override
  Widget build(BuildContext context) {
    Future<CityForecast> fetchData() async {
      if (name.isNotEmpty) {
        return cityViewModel.fetchForcastByName(name);
      } else if (lat != 0 && lon != 0) {
        return cityViewModel.fetchForcastByLatLon(lat, lon);
      }
      return CityForecast.fromJson({});
    }

    Text getTitle() {
      if (name.isNotEmpty) {
        return Text('$name forcast');
      } else if (lat != 0 && lon != 0) {
        return Text('lat: $lat lon: $lon forcast');
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
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final cityForecast = snapshot.data!;
              return ListView.builder(
                itemCount: cityForecast.forecast.forecastday.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      Utility.formatEpochTime(cityForecast.forecast.forecastday[index].dateEpoch)),
                    subtitle: Text(
                      cityForecast.forecast.forecastday[index].dayCondition.condition.code.toString()),
                  );
                },
              );
            }
          }),
    );
  }
}
