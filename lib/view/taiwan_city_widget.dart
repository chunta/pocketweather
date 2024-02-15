import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class TaiwanCityWidget extends StatelessWidget {
  final CityViewModel cityViewModel;

  const TaiwanCityWidget({super.key, required this.cityViewModel});

  @override
  Widget build(BuildContext context) {
    cityViewModel.fetchTaiwanCities();
    return Scaffold(
      body: StreamBuilder<List<CityForecast>>(
        stream: cityViewModel.getTaiwanCitiesStream(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final city = snapshot.data![index];
                        return ListTile(
                          title: Text(city.location.name,
                              style: const TextStyle(fontSize: 28)),
                          subtitle: Text(
                              '${city.current.currentTemp} ${city.location.lat} ${city.location.lon} ${city.location.lat}',
                              style: const TextStyle(fontSize: 25)),
                        );
                      }, childCount: snapshot.data!.length),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
