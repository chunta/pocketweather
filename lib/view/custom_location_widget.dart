import 'package:flutter/material.dart';
import 'package:pocket_weather/model/custom_location_repository.dart';
import 'package:pocket_weather/view_model/city_view_model.dart';
import 'package:logger/logger.dart';
import 'package:pocket_weather/view_model/custom_location_view_model.dart';

class CustomLocationWidget extends StatelessWidget {
  final logger = Logger();

  final CustomLocationViewModel customLocationViewModel;

  CustomLocationWidget({super.key, required this.customLocationViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
              Text('My Custom Location', style: const TextStyle(fontSize: 20)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  labelText: 'Lat',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  labelText: 'Lon',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  labelText: 'Label',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  logger.d("save custom location to user preference");
                },
                child: Text('Save'),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item $index'),
                      onTap: () {
                        logger.d("one saved record is tapped");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
