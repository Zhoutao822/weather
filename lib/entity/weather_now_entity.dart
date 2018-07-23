import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherNowEntity {
  final String location;
  final String lat;
  final String lon;
  final String loc;
  final String tmp;
  final String condcode;
  final String condtxt;
  final String windsc;
  final String hum;
  final String status;

  bool get isValid =>
      location != null && condtxt != null && condcode != null && tmp != null;

  WeatherNowEntity(
      {@required this.location,
      @required this.lat,
      @required this.lon,
      @required this.loc,
      @required this.tmp,
      @required this.condcode,
      @required this.condtxt,
      @required this.windsc,
      @required this.hum,
      @required this.status});

  static WeatherNowEntity allFromResponse(http.Response response) {
    String data = response.body;
    Map infoMap = json.decode(data);
    List info = infoMap["HeWeather6"];
    return WeatherNowEntity.fromMap(info[0]);
  }

  static WeatherNowEntity fromMap(Map map) {
    return new WeatherNowEntity(
      location: map['basic']['location'],
      lat: map['basic']['lat'],
      lon: map['basic']['lon'],
      loc: map['update']['loc'],
      tmp: map['now']['tmp'],
      condcode: map['now']['cond_code'],
      condtxt: map['now']['cond_txt'],
      windsc: map['now']['wind_sc'],
      hum: map['now']['hum'],
      status: map['status'],
    );
  }
}
