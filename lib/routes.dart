import 'package:pocket_weather/main.dart';
import 'package:pocket_weather/view/city_forcast_widget.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';

class Routers {
  static String root = "/";
  static String cityForcast = '/city_forcast';

  static final routers = {
    root: (context) => const HomePage(),
    cityForcast: (context) =>
        CityForecastWidget(cityViewModel: CityViewModel()),
  };
}
