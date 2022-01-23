abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherCurrentPositionRequested extends WeatherEvent {
  final String? lat;
  final String? lng;

  WeatherCurrentPositionRequested(this.lat, this.lng);
}

class WeatherRequested extends WeatherEvent {
  final String lat;
  final String lng;

  const WeatherRequested(this.lat, this.lng);
}

class WeatherSubmitted extends WeatherEvent {
  final int indexHour;
  final int indexDay;

  const WeatherSubmitted({this.indexDay = 0, this.indexHour = 0});
}
