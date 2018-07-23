import 'dart:async';

import 'package:http/http.dart' as http;
import 'entity/weather_now_entity.dart';
import 'entity/air_now_entity.dart';

class Utils {
  static String baseUrl = "https://free-api.heweather.com/s6/";
  static String typeWeather = "weather/";
  static String typeAir = "air/";
  static String typeNow = "now?";
  static String key = "key=ba3757d47655431eb582d1ac63f08814";
  static String lo = "&location=";

  static String nowWeatherUrl = baseUrl + typeWeather + typeNow + key + lo;
  static String nowAirUrl = baseUrl + typeAir + typeNow + key + lo;

  static Future<WeatherNowEntity> getNowWeatherData(String location) async {
    http.Response response =
        await http.get(baseUrl + typeWeather + typeNow + lo + location + key);
    return WeatherNowEntity.allFromResponse(response);
  }

  static Future<AirNowEntity> getNowAirData(String location) async {
    http.Response response =
        await http.get(baseUrl + typeAir + typeNow + lo + location + key);
    return AirNowEntity.allFromResponse(response);
  }
}
