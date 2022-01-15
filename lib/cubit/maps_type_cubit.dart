import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MapsTypeEvent { hybrid, none, normal, satellite, terrain }

class MapsTypeBloc extends Bloc<MapsTypeEvent, MapType> {
  MapsTypeBloc() : super(MapType.normal) {
    on<MapsTypeEvent>((event, emit) {
      switch (event) {
        case MapsTypeEvent.hybrid:
          emit(MapType.hybrid);
          break;
        case MapsTypeEvent.none:
          emit(MapType.none);
          break;
        case MapsTypeEvent.normal:
          emit(MapType.normal);
          break;
        case MapsTypeEvent.satellite:
          emit(MapType.satellite);
          break;
        case MapsTypeEvent.terrain:
          emit(MapType.terrain);
          break;
      }
    });
  }
}
