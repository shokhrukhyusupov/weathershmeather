import 'package:weathershmeather/models/weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherLoading extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather currentWeather;
  final List<Weather> hourlyWeather;
  final List<Weather> dailyWeather;
  final int weatherHourIndex;
  final int weatherDayIndex;

  const WeatherLoadSuccess({
    required this.currentWeather,
    required this.hourlyWeather,
    required this.dailyWeather,
    this.weatherHourIndex = 0,
    this.weatherDayIndex = 0,
  });

  WeatherLoadSuccess changeIndex(int indexHour, int indexDay) {
    return WeatherLoadSuccess(
      currentWeather: currentWeather,
      hourlyWeather: hourlyWeather,
      dailyWeather: dailyWeather,
      weatherHourIndex: indexHour,
      weatherDayIndex: indexDay,
    );
  }
}

class WeatherLoadFailed extends WeatherState {}
