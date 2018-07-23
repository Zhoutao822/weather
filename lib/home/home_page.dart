import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global_config.dart';
import 'package:meta/meta.dart';
import 'city_item.dart';
import '../entity/air_now_entity.dart';
import 'search_page.dart';
import '../utils.dart';
import '../entity/weather_now_entity.dart';
import '../entity/air_now_entity.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static const double height = 300.0;

  List<CityItem> _cityList = [];
  List<String> _cityName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readCities().then((List<String> list) {
      setState(() {
        for (String city in list) {
          getNowWeatherAndAirData(city);
        }
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/cities.txt');
  }

  Future<List<String>> _readCities() async {
    try {
      File file = await _getLocalFile();
      String content = await file.readAsString();
      print(content);
      return content.split(',').toList();
    } on FileSystemException {
      print("fail");
      return ['suzhou'];
    }
  }

  Future<Null> _writeCities() async {
    String contents = "";
    for (String city in _cityName) {
      contents += city + ',';
    }
    await (await _getLocalFile()).writeAsString(contents);
    print(contents);
  }

  void _search(BuildContext context) async {
    final result =
        await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new SearchPage();
    }));
    if (result != null) getNowWeatherAndAirData(result);
  }

  getNowWeatherAndAirData(String location) async {
    http.Response responseWeather =
        await http.get(Utils.nowWeatherUrl + location);
    http.Response responseAir = await http.get(Utils.nowAirUrl + location);
    WeatherNowEntity weatherNowEntity =
        WeatherNowEntity.allFromResponse(responseWeather);
    AirNowEntity airNowEntity = AirNowEntity.allFromResponse(responseAir);
    setState(() {
      _cityName.add(location);
      CityItem cityItem = new CityItem(
          weatherNowEntity: weatherNowEntity, airNowEntity: airNowEntity);
      _cityList.add(cityItem);
      _writeCities();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("天气"),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _search(context);
              },
            ),
          ],
        ),
        body: new ListView.builder(
            itemCount: _cityList.isEmpty ? 0 : _cityList.length,
            itemBuilder: (context, index) {
              final item = _cityList[index];
              return new Dismissible(
                  key: new Key(item.toString()),
                  onDismissed: (direction) {
                    if (_cityList.contains(item)) {
                      _cityList.remove(item);
                      _cityName.remove(item.weatherNowEntity.location);
                      Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("dismissed" + index.toString())));
                    }
                  },
                  background: new Container(
                    color: Colors.white,
                  ),
                  child: _cityList[index]);
            }),
      ),
      theme: GlobalConfig.themeData,
    );
  }
}
