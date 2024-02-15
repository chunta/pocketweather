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
            tabs: [
              Text("World City"),
              Text("Taiwan City")
            ],
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

/*
class Frog extends StatelessWidget {
  const Frog(
      {super.key,
      this.color = const Color(0xFF2DBD3A),
      this.child,
      required this.cityViewModel});

  final Color color;
  final Widget? child;
  final CityViewModel cityViewModel;

  @override
  Widget build(BuildContext context) {
    print("process line 75....");
    cityViewModel.fetchWorldFamousCities();
    return StreamBuilder<List<CityForecast>>(
        stream: cityViewModel.getWorldCitiesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('Data: ${snapshot.data?.length}');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void dispose() {
    print("Frog - dispose is called ${hashCode}");
  }
}
*/