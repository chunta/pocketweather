import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class TaiwanCityWidget extends StatelessWidget {
  final CityViewModel cityViewModel;

  const TaiwanCityWidget({super.key, required this.cityViewModel});

  @override
  Widget build(BuildContext context) {
    cityViewModel.fetchTaiwanCities();
     return StreamBuilder<List<CityForecast>>(
      stream: cityViewModel.getTaiwanCitiesStream(), 
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
                title: Text(city.location.name, style: const TextStyle(fontSize: 20)),
                subtitle: Text('${city.current.currentTemp}', style: const TextStyle(fontSize: 15)),
              );
            });
        }
      });
  }
}
