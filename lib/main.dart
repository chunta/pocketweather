import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/view/world_city_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';
import 'package:pocket_weather/view/taiwan_city_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tabs Example'),
          bottom: const TabBar(
            tabs: [Text("World City"), Text("Taiwan City")],
          ),
        ),
        body: TabBarView(
          children: [
            WorldCityWidget(cityViewModel: CityViewModel()),
            TaiwanCityWidget(cityViewModel: CityViewModel()),
          ],
        ),
      ),
    );
  }
}
