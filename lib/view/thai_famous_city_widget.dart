import 'package:flutter/material.dart';
import 'package:pocket_weather/model/repository/thai_famous_city_repository.dart';
import 'package:pocket_weather/view_model/thai_famous_city_view_model.dart';
import 'package:provider/provider.dart';

class ThaiFamousCityWidget extends StatelessWidget {
  final ThaiFamousCityViewModel thaiCityViewModel;

  const ThaiFamousCityWidget({super.key, required this.thaiCityViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Row(children: [Divider()],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: Text(thaiCityViewModel.nameFromNameCity(ThaiFamousCity.bangkok)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(thaiCityViewModel.nameFromNameCity(ThaiFamousCity.chiangMai)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(thaiCityViewModel.nameFromNameCity(ThaiFamousCity.phuket)),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
                // Add more ListTiles as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
