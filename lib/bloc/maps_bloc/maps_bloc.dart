import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/models/place.dart';
import 'package:weathershmeather/services/location_service.dart';

import 'maps_event.dart';
import 'maps_state.dart';
import 'maps_status.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsState()) {
    on<SelectedLocationRequested>((event, emit) async {
      try {
        final List<Place> places = await LocationService.getPlace(event.place);
        emit(state.copyWith(places: places, mapsStatus: MapsLoadedSuccess()));
      } catch (e) {
        emit(state.copyWith(mapsStatus: MapsLoadFailed(Exception(e))));
      }
    });
    on<MarkedLocation>((event, emit) async {
      final icon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 3.5, size: Size(4, 4)),
          'assets/images/google_maps/marker.png');
      emit(state.copyWith(markers: {
        Marker(
          markerId: const MarkerId('1'),
          position: event.position,
          icon: icon,
        ),
      }));
    });
  }
}
