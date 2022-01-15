import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherForecastScreenWeatherList extends StatelessWidget {
  const WeatherForecastScreenWeatherList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      child: ListView.builder(
        itemCount: 24,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    '22 Nov, Monday',
                    style: TextStyle(
                        color: Color(0xFF5897FD), fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Text(
                        '17°',
                        style: TextStyle(color: Colors.black26, fontSize: 26),
                      ),
                      Text('/ 22°', style: TextStyle(color: Colors.black26, fontSize: 20)),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/3d_weather_icons/50n.png",
                        height: 35,
                        width: 35,
                      ),
                      const Text(
                        'Cloudy',
                        style: TextStyle(
                          color: Color(0xFF806EF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
