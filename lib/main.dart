import 'package:flutter/material.dart';
import 'package:pocket_weather/model/city_current.dart';
import 'package:pocket_weather/model/city_forecast.dart';
import 'package:pocket_weather/model/city_forecast_day.dart';
import 'package:pocket_weather/model/city_location.dart';
import 'package:pocket_weather/model/day_condition.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/model/weather_condition.dart';
import 'package:pocket_weather/routes.dart';
import 'package:pocket_weather/view/custom_location_widget.dart';
import 'package:pocket_weather/view/thai_famous_city_widget.dart';
import 'package:pocket_weather/view/world_city_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';
import 'package:pocket_weather/view/taiwan_city_widget.dart';
import 'package:pocket_weather/view_model/custom_location_view_model.dart';
import 'package:pocket_weather/view_model/thai_city_view_model.dart';

class ThaiViewModelMock with ChangeNotifier implements ThaiCityViewModel {

  @override
  CityForecast cityForecast = CityForecast.fromJson({});

  ThaiViewModelMock._();

  static final ThaiViewModelMock _instance = ThaiViewModelMock._();

  factory ThaiViewModelMock() {
    return _instance;
  }

  @override
  Future<void> fetchForcastByNameCase(ThaiFamousCity city) async {
    await Future.delayed(const Duration(seconds: 1));
    final mockCurrentCondition = WeatherCondition.fromJson({'code': 100});
    final mockCurrent = CityCurrent(condition: mockCurrentCondition, currentTemp: 10, lastUpdatedEpoch: 100);
    final mockLocation = CityLocation.fromJson({'name': 'mock_bankkok', 'lat': 1.0, 'lon': 2.0});
    final day00Condition = WeatherCondition.fromJson({'code': 10});
    final mockForcastdays00 = Forecastday(dateEpoch: 0, dayCondition: DayCondition(avghumidity: 0, maxtemp: 10.2, mintemp: 0.0, condition: day00Condition));
    final mockForcast = Forecast(forecastday: [mockForcastdays00]);
    cityForecast = CityForecast(current: mockCurrent, location: mockLocation, forecast: mockForcast);
    notifyListeners();
  }

  @override
  String nameFromNameCity(ThaiFamousCity city) {
    return "Bangkok";
  }
}

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
            ThaiParentWidget(viewModel: ThaiViewModelMock(),),
          ],
        ),
      ),
    );
  }
}
