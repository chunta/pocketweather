import 'package:flutter/material.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class WorldCityWidget extends StatelessWidget {
  final CityViewModel cityViewModel;

  const WorldCityWidget({super.key, required this.cityViewModel});

  @override
  Widget build(BuildContext context) {
    return const Text("World City");
  }
}
