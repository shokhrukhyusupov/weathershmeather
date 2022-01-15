import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/cubit/maps_type_cubit.dart';
import 'package:weathershmeather/models/weather.dart';
import 'package:weathershmeather/pages/maps_screen.dart';

class Locatia extends StatefulWidget {
  final Weather currentWeather;
  const Locatia(this.currentWeather, {Key? key}) : super(key: key);

  @override
  State<Locatia> createState() => _LocatiaState();
}

class _LocatiaState extends State<Locatia> {
  @override
  Widget build(BuildContext context) {
    const _initialCameraPosition = CameraPosition(
      target: LatLng(41.30, 69.25),
      zoom: 10.0,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tashkent, asdf',
                maxLines: 2,
                style: TextStyle(
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
        ClipRRect(
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
              initialCameraPosition: _initialCameraPosition,
            ),
          ),
        ),
      ],
    );
  }
}
