import 'package:flutter/material.dart';
import 'package:pocket_weather/routes.dart';
import 'package:pocket_weather/view/custom_location_widget.dart';
import 'package:pocket_weather/view/world_city_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';
import 'package:pocket_weather/view/taiwan_city_widget.dart';
import 'package:pocket_weather/view_model/custom_location_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket weather',
      initialRoute: Routers.root,
      routes: Routers.routers,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pocket Weather',
            style: TextStyle(fontSize: 13),
          ),
          bottom: const TabBar(
            tabs: [
              Text("World City"),
              Text("Taiwan City"),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Custom Location"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WorldCityWidget(cityViewModel: CityViewModel()),
            TaiwanCityWidget(cityViewModel: CityViewModel()),
            CustomLocationWidget(
                customLocationViewModel: CustomLocationViewModel())
          ],
        ),
      ),
    );
  }
}
