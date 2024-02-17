import 'package:flutter/material.dart';
import 'package:pocket_weather/model/weather_condition_table.dart';
import 'package:pocket_weather/routes.dart';
import 'package:pocket_weather/view/custom_location_widget.dart';
import 'package:pocket_weather/view/thai_famous_city_widget.dart';
import 'package:pocket_weather/view/world_city_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';
import 'package:pocket_weather/view/taiwan_city_widget.dart';
import 'package:pocket_weather/view_model/custom_location_view_model.dart';
import 'package:pocket_weather/view_model/thai_famous_city_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pocket Weather',
            style: TextStyle(fontSize: 13),
          ),
          bottom: const TabBar(
            tabs: [
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("World City", style: TextStyle(fontSize: 13))),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Taiwan City", style: TextStyle(fontSize: 13))),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Custom Place", style: TextStyle(fontSize: 13))),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Thai City", style: TextStyle(fontSize: 13)))
            ],
            labelPadding: EdgeInsets.symmetric(
                horizontal: 11.0,
                vertical: 7.0), // Add padding around the tab labels
          ),
        ),
        body: TabBarView(
          children: [
            WorldCityWidget(cityViewModel: CityViewModel()),
            TaiwanCityWidget(cityViewModel: CityViewModel()),
            CustomLocationWidget(
                customLocationViewModel: CustomLocationViewModel()),
            const ThaiParentWidget(),
          ],
        ),
      ),
    );
  }
}
