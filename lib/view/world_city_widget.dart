import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/routes.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class WorldCityWidget extends StatelessWidget {
  final CityViewModel cityViewModel;

  const WorldCityWidget({super.key, required this.cityViewModel});

  @override
  Widget build(BuildContext context) {
    cityViewModel.fetchWorldFamousCities();
    return StreamBuilder<List<CityForecast>>(
        stream: cityViewModel.getWorldCitiesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                width: 50, // Set the width
                height: 50, // Set the height
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final city = snapshot.data![index];
                  return ListTile(
                    title: Text(city.location.name,
                        style: const TextStyle(fontSize: 28)),
                    subtitle: Text('${city.current.currentTemp}',
                        style: const TextStyle(fontSize: 25)),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routers.cityForcast,
                          arguments: {
                            'name': city.location.name,
                            'lat': 0.0,
                            'lon': 0.0
                          });
                    },
                  );
                });
          }
        });
  }
}
