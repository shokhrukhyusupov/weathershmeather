import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_event.dart';
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

class HomePage extends StatelessWidget {
  final String email, uid, displayName;
  final String? photoUrl;
  const HomePage({
    required this.email,
    required this.uid,
    required this.displayName,
    this.photoUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot<Map<String, dynamic>>> places = FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('address')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: places,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.requireData;
          try {
            return HomeScreen(
              displayName: displayName,
              email: email,
              uid: uid,
              place: data.docs[0]['formattedAddress'],
              lat: data.docs[0]['lat'].toString(),
              lng: data.docs[0]['lng'].toString(),
              photoUrl: photoUrl,
            );
          } catch (e) {
            return HomeScreen(
              displayName: displayName,
              email: email,
              uid: uid,
              photoUrl: photoUrl,
            );
          }
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String email, uid, displayName;
  final String? place, lat, lng, photoUrl;
  const HomeScreen({
    required this.email,
    required this.uid,
    required this.displayName,
    this.place,
    this.lat,
    this.lng,
    this.photoUrl,
    Key? key,
  }) : super(key: key);

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
        .add(WeatherCurrentPositionRequested(widget.lat, widget.lng));
    BlocProvider.of<MapsBloc>(context)
        .add(SelectedLocationRequested(widget.place));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            if (widget.place == null) {
              final timezone = state.currentWeather.timezone!.split('/');
              BlocProvider.of<MapsBloc>(context)
                  .add(SelectedLocationRequested(timezone[1]));
            }
            return Stack(
              children: [
                DrawerScreen(
                  displayName: widget.displayName,
                  email: widget.email,
                  photoUrl: widget.photoUrl,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  transform: Matrix4.translationValues(xOffset, yOffset, 0)
                    ..scale(scaleFactor),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                    color: const Color(0xFFF7F7F7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(-2, 10),
                        blurRadius: 15,
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      HomeScreenAppbar(
                        email: widget.email,
                        uid: widget.uid,
                        displayName: widget.displayName,
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
