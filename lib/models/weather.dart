import 'package:intl/intl.dart';

class Weather {
  String? dt;
  String? dtE;
  String? timezone;
  int? temp;
  int? feelsLike;
  int? pressure;
  int? humidity;
  int? clouds;
  int? visibility;
  int? windSpeed;
  String? description;
  int? max;
  int? min;
  String? icon;

  Weather({
    this.dt,
    this.dtE,
    this.timezone,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.description,
    this.max,
    this.min,
    this.icon,
  });

  factory Weather.fromCurrentWeather(Map<String, dynamic> json) {
    return Weather(
      dt: DateFormat('EEEEE, d MMM', 'en_US').format(
          DateTime.fromMillisecondsSinceEpoch(json['current']['dt'] * 1000)),
      timezone: json['timezone'],
      temp: double.parse(json['current']['temp'].toString()).toInt(),
      feelsLike: double.parse(json['current']['feels_like'].toString()).toInt(),
      pressure: json['current']['pressure'],
      humidity: double.parse(json['current']['humidity'].toString()).toInt(),
      clouds: json['current']['clouds'],
      visibility: json['current']['visibility'],
      windSpeed: double.parse(json['current']['wind_speed'].toString()).toInt(),
      description: json['current']['weather'][0]['description'],
      icon: json['current']['weather'][0]['icon'],
    );
  }

  factory Weather.fromHourlyWeather(Map<String, dynamic> json) {
    return Weather(
      dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toString(),
      temp: double.parse(json['temp'].toString()).toInt(),
      feelsLike: double.parse(json['feels_like'].toString()).toInt(),
      pressure: json['pressure'],
      humidity: double.parse(json['humidity'].toString()).toInt(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: double.parse(json['wind_speed'].toString()).toInt(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

  factory Weather.fromDailyWeather(Map<String, dynamic> json) {
    return Weather(
      dt: DateFormat.d()
          .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      dtE: DateFormat.E()
          .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      max: double.parse(json['temp']['max'].toString()).toInt(),
      min: double.parse(json['temp']['min'].toString()).toInt(),
      feelsLike: double.parse(json['feels_like']['day'].toString()).toInt(),
      pressure: json['pressure'],
      humidity: double.parse(json['humidity'].toString()).toInt(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: double.parse(json['wind_speed'].toString()).toInt(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
