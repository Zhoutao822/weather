import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AirNowEntity {
  final String location;
  final String pubtime;

  final String status;
  final String aqi;
  final String qlty;

  bool get isValid => location != null && status != null && aqi != null;

  AirNowEntity(
      {@required this.location,
      @required this.pubtime,
      @required this.status,
      @required this.aqi,
      @required this.qlty});

  static AirNowEntity allFromResponse(http.Response response) {
    String data = response.body;
    Map infoMap = json.decode(data);
    List info = infoMap["HeWeather6"];
    return AirNowEntity.fromMap(info[0]);
  }

  static AirNowEntity fromMap(Map map) {
    return new AirNowEntity(
        location: map['basic']['location'],
        pubtime: map['air_now_city']['pub_time'],
        status: map['status'],
        aqi: map['air_now_city']['aqi'],
        qlty: map['air_now_city']['qlty']);
  }
}
