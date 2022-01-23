import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_state.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_status.dart';
import 'package:weathershmeather/cubit/maps_type_cubit.dart';
import 'package:weathershmeather/models/weather.dart';
import 'package:weathershmeather/pages/maps_screen.dart';

class Locatia extends StatefulWidget {
  final Weather currentWeather;
  const Locatia(this.currentWeather, {Key? key}) : super(key: key);

  @override
  State<Locatia> createState() => _LocatiaState();
}

class _LocatiaState extends State<Locatia> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> completer = Completer();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(builder: (context, state) {
      if (state.mapsStatus is MapsLoadedSuccess) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.places![0].formattedAddress,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.currentWeather.dt}',
                    style: const TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                ],
              ),
            ),
            BlocBuilder<MapsBloc, MapsState>(builder: (context, state) {
              if (state.mapsStatus is MapsLoadedSuccess) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 87,
                    width: 150,
                    child: GoogleMap(
                      onTap: (_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => MapsTypeBloc(),
                                child: const MapsScreen(),
                              );
                            },
                          ),
                        );
                      },
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              state.places![0].lat, state.places![0].lng),
                          zoom: 6),
                      onMapCreated: (controller) =>
                          completer.complete(controller),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
