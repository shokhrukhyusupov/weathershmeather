import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_state.dart';
import 'package:weathershmeather/components/home_screen_components/home_screen_appbar.dart';
import 'package:weathershmeather/components/home_screen_components/home_screen_weather.dart';
import 'package:weathershmeather/components/home_screen_components/home_screen_weather_list.dart';
import 'package:weathershmeather/components/home_screen_components/locatia.dart';
import 'package:weathershmeather/components/home_screen_components/weather_components.dart';
import 'package:weathershmeather/pages/drawer_screen.dart';
import 'package:weathershmeather/pages/weather_forecast_screen.dart';

import 'skeleton_home_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email, uid, displayName;
  final String? photoUrl;
  const HomeScreen(
      {required this.email,
      required this.uid,
      required this.displayName,
      this.photoUrl,
      Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double xOffset = 0, yOffset = 0, scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context)
        .add(WeatherCurrentPositionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Stack(
              children: [
                const DrawerScreen(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  transform: Matrix4.translationValues(xOffset, yOffset, 0)
                    ..scale(scaleFactor),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                    color: const Color(0xFFF7F7F7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(-5, 15),
                        blurRadius: 15,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      HomeScreenAppbar(
                        email: widget.email,
                        uid: widget.uid,
                        displayName: widget.displayName,
                        photoUrl: widget.photoUrl,
                      ),
                      Locatia(state.currentWeather),
                      HomeScreenWeather(
                          state.hourlyWeather[state.weatherHourIndex]),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: WeatherComponents(
                            state.hourlyWeather[state.weatherHourIndex]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const WeatherForecastScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Text('Next 7 Days ',
                                      style: TextStyle(fontSize: 16)),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      HomeScreenWeatherList(
                          state.hourlyWeather, state.weatherHourIndex),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is WeatherLoading) {
            return const SkeletonHomeScreen();
          } else if (state is WeatherLoadFailed) {
            return const Center(
                child: Text('error', style: TextStyle(fontSize: 50)));
          } else {
            return const Center(
                child: Text('??????', style: TextStyle(fontSize: 50)));
          }
        },
      ),
    );
  }
}
