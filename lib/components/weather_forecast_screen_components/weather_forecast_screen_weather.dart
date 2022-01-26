import 'package:flutter/material.dart';
import 'package:weathershmeather/models/weather.dart';

class WeatherForecastScreenWeather extends StatelessWidget {
  final Weather dailyWeather;
  const WeatherForecastScreenWeather(this.dailyWeather, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 280,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFAECCFF),
                      Color(0xFF5897FD),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade900.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 14,
                      offset: const Offset(0, 25), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 1),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${dailyWeather.max}°',
                                  style: const TextStyle(
                                    color: Color(0xAAFFFFFF),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '/ ${dailyWeather.min}°',
                                  style: const TextStyle(
                                    color: Color(0xAAFFFFFF),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Feels like ${dailyWeather.feelsLike}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${dailyWeather.description}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          "assets/images/3d_weather_icons/36.png",
                          height: 70,
                          width: 70,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/3d_weather_icons/humidity.png",
                                width: 45,
                                height: 45,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text('${dailyWeather.humidity}%',
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/3d_weather_icons/wind.png",
                                width: 45,
                                height: 45,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text('${dailyWeather.windSpeed}km/h',
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/3d_weather_icons/indicator.png",
                                width: 45,
                                height: 45,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text('${dailyWeather.pressure}mb',
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset("assets/images/3d_weather_icons/${dailyWeather.icon}.png",
                  height: 120, width: 120),
            ),
          ],
        ),
      ),
    );
  }
}
