import 'package:flutter/material.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class CityForecastWidget extends StatelessWidget {
  final CityViewModel cityViewModel;
  const CityForecastWidget({super.key, required this.cityViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Forecast'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(
        child: Text('City Forecast Screen'),
      ),
    );
  }
}
