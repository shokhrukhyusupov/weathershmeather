import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_state.dart';
import 'package:weathershmeather/components/weather_forecast_screen_components/daily_weather_list.dart';
import 'package:weathershmeather/components/weather_forecast_screen_components/weather_forecast_appbar.dart';
import 'package:weathershmeather/components/weather_forecast_screen_components/weather_forecast_screen_list.dart';
import 'package:weathershmeather/components/weather_forecast_screen_components/weather_forecast_screen_weather.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadSuccess) {
          return Scaffold(
            backgroundColor: const Color(0xFF629EFF),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 280.0),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: WeatherForecastScreenWeatherList(),
                ),
                Column(
                  children: [
                    const WeatherForecastScreenAppBar(),
                    DailyWeatherList(state.dailyWeather, state.weatherDayIndex),
                    WeatherForecastScreenWeather(state.dailyWeather[state.weatherDayIndex + 1]),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
