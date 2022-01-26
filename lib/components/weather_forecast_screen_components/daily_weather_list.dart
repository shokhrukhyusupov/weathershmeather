import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';
import 'package:weathershmeather/models/weather.dart';

class DailyWeatherList extends StatelessWidget {
  final List<Weather> dailyWeather;
  final int selectedIndex;
  const DailyWeatherList(this.dailyWeather, this.selectedIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context
                        .read<WeatherBloc>()
                        .add(WeatherSubmitted(indexDay: i));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: selectedIndex == i
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFECECEC),
                                  Colors.white,
                                ],
                              )
                            : const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white30,
                                  Colors.white12,
                                  Colors.white12,
                                ],
                              )),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/3d_weather_icons/${dailyWeather[i + 1].icon}.png",
                          width: 35,
                          height: 35,
                        ),
                        Text(
                          '${dailyWeather[i + 1].dt}',
                          style: TextStyle(
                            color: selectedIndex == i
                                ? const Color(0xFF806EF8)
                                : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          '${dailyWeather[i + 1].dtE}',
                          style: TextStyle(
                            color: selectedIndex == i
                                ? const Color(0xFF806EF8)
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
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
