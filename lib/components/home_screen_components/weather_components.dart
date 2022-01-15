import 'package:flutter/material.dart';
import 'package:weathershmeather/models/weather.dart';

class WeatherComponents extends StatelessWidget {
  final Weather currentWeather;
  const WeatherComponents(this.currentWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/3d_weather_icons/humidity.png",
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 5),
            Text('${currentWeather.humidity}%',
                style: const TextStyle(color: Colors.black)),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/3d_weather_icons/wind.png",
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 5),
            const Text('8km/h', style: TextStyle(color: Colors.black)),
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/3d_weather_icons/indicator.png",
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 5),
            Text('${currentWeather.pressure}mb',
                style: const TextStyle(color: Colors.black)),
          ],
        ),
      ],
    );
  }
}
