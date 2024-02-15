import 'package:pocket_weather/main.dart';
import 'package:pocket_weather/view/city_forcast_widget.dart';
import 'package:pocket_weather/view/custom_location_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class Routers {
  static String root = "/";
  static String cityForcast = '/city_forcast';
  static String customLocation = '/custom_location';

  static final routers = {
    root: (context) => const HomePage(),
    cityForcast: (context) => const CityForecastWidget(),
    customLocation: (context) =>
        CustomLocationWidget(cityViewModel: CityViewModel())
  };
}