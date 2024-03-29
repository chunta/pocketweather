import 'package:flutter/material.dart';
import 'package:pocket_weather/model/custom_location.dart';
import 'package:pocket_weather/routes.dart';
import 'package:pocket_weather/view_model/custom_location_view_model.dart';
import 'package:logger/logger.dart';

class CustomLocationWidget extends StatefulWidget {
  final CustomLocationViewModel customLocationViewModel;

  const CustomLocationWidget({Key? key, required this.customLocationViewModel})
      : super(key: key);

  @override
  _CustomLocationWidgetState createState() => _CustomLocationWidgetState();
}

class _CustomLocationWidgetState extends State<CustomLocationWidget> {
  final logger = Logger();
  bool _isSaving = false;
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController labelController = TextEditingController();

  @override
  Widget build(BuildContext widgetContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: latController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelText: 'Lat',
                ),
              ),
              TextField(
                controller: lonController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelText: 'Lon',
                ),
              ),
              TextField(
                controller: labelController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelText: 'Label',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isSaving = true;
                    logger.d("start saving....");
                  });
                  logger.d("save custom location to user preference");
                  bool result = await widget.customLocationViewModel
                      .saveCustomLocation(
                          double.parse(latController.text),
                          double.parse(lonController.text),
                          labelController.text);
                  logger.d('save result $result');
                  setState(() {
                    _isSaving = false;
                    logger.d("finish saving....");
                    latController.text = "";
                    lonController.text = "";
                    labelController.text = "";
                  });
                },
                child: const Text('Save'),
              ),
              if (_isSaving) const CircularProgressIndicator(),
              const Divider(),
              Expanded(
                child: FutureBuilder<Map<String, CustomLocation>>(
                  future:
                      widget.customLocationViewModel.getAllCustomLocations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text('${snapshot.error}',
                                      style: const TextStyle(fontSize: 18)))));
                    } else {
                      final customLocations = snapshot.data ?? {};
                      return ListView.builder(
                        itemCount: customLocations.length,
                        itemBuilder: (context, index) {
                          final key = customLocations.keys.elementAt(index);
                          final customLocation = customLocations[key];
                          return ListTile(
                            title: Text(customLocation?.label ?? '',
                                style: const TextStyle(fontSize: 28)),
                            subtitle: Text(
                                "${customLocation?.lat} ${customLocation?.lon}",
                                style: const TextStyle(fontSize: 25)),
                            onTap: () {
                              logger.d(
                                  "one saved record is tapped ${customLocation?.label ?? ''}");
                              Navigator.of(widgetContext).pushNamed(
                                Routers.cityForcast,
                                arguments: {
                                  'name': "",
                                  'lat': customLocation?.lat ?? 0.0,
                                  'lon': customLocation?.lon ?? 0.0,
                                },
                              );
                            },
                          );
                        },
                      );
                    }
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
