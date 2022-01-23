import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_state.dart';
import 'package:weathershmeather/models/weather.dart';
import 'package:weathershmeather/repository/maps_repository.dart';
import 'package:weathershmeather/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final MapsRepository mapsRepo;
  WeatherBloc({required this.mapsRepo}) : super(WeatherLoading()) {
    on<WeatherCurrentPositionRequested>((event, emit) async {
      if (event.lat != null && event.lng != null) {
        add(WeatherRequested(event.lat!, event.lng!));
      } else {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          try {
            Position currentPosition = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            add(WeatherRequested(currentPosition.latitude.toString(),
                currentPosition.longitude.toString()));
          } catch (e) {
            add(const WeatherRequested('51.5072178', '-0.1275862'));
          }
        } else if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          LocationPermission permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            add(const WeatherRequested('51.5072178', '-0.1275862'));
          } else {
            add(WeatherCurrentPositionRequested(null, null));
          }
        }
      }
    });
    on<WeatherRequested>((event, emit) async {
      try {
        final Weather currentWeather = await WeatherService.fetchCurrentWeather(
            lat: event.lat, lng: event.lng);
        final List<Weather> hourlyWeather =
            await WeatherService.fetchHourlyWeather(
                lat: event.lat, lng: event.lng);
        final List<Weather> dailyWeather =
            await WeatherService.fetchDailyWeather(
                lat: event.lat, lng: event.lng);
        emit(WeatherLoadSuccess(
            currentWeather: currentWeather,
            hourlyWeather: hourlyWeather,
            dailyWeather: dailyWeather));
      } catch (e) {
        emit(WeatherLoadFailed());
      }
    });
    on<WeatherSubmitted>((event, emit) {
      final copyState = state;
      if (copyState is WeatherLoadSuccess) {
        emit(copyState.changeIndex(event.indexHour, event.indexDay));
      }
    });
  }
}
