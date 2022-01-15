import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weathershmeather/models/weather.dart';

class WeatherService {
  static const String _apiKey = '366eb5e76f5a5fa2f39445414a07f5d2';

  static Future<Weather> fetchCurrentWeather(
      {required String lat, required String lng}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=alerts,minutely&units=metric&appid=$_apiKey';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromCurrentWeather(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<Weather>> fetchHourlyWeather(
      {required String lat, required String lng}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=alerts,minutely&units=metric&appid=$_apiKey';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<Weather> result = (json['hourly'] as List<dynamic>)
          .map((item) => Weather.fromHourlyWeather(item))
          .toList();
      return result;
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<List<Weather>> fetchDailyWeather(
      {required String lat, required String lng}) async {
    String url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=alerts,minutely&units=metric&appid=$_apiKey';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<Weather> result = (json['daily'] as List<dynamic>)
          .map((item) => Weather.fromDailyWeather(item))
          .toList();
      return result;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
