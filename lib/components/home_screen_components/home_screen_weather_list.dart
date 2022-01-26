import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';
import 'package:weathershmeather/models/weather.dart';

class HomeScreenWeatherList extends StatelessWidget {
  final List<Weather> hourlyWeather;
  final int weatherHourIndex;
  const HomeScreenWeatherList(this.hourlyWeather, this.weatherHourIndex,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<WeatherBloc>().add(WeatherSubmitted(indexHour: i));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: weatherHourIndex == i
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFB0A4FF),
                                Color(0xFF806EF8),
                              ],
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            i == 0
                                ? 'Now'
                                : hourlyWeather[i].dt!.substring(11, 16),
                            style: TextStyle(
                              color: weatherHourIndex == i
                                  ? Colors.white
                                  : Colors.black26,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            "assets/images/3d_weather_icons/${hourlyWeather[i].icon}.png",
                            width: 35,
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              '${hourlyWeather[i].temp}°',
                              style: TextStyle(
                                color: weatherHourIndex == i
                                    ? Colors.white
                                    : Colors.black26,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
