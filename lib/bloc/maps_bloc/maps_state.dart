import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_status.dart';
import 'package:weathershmeather/models/place.dart';

class MapsState {
  final List<Place>? places;
  final Set<Marker>? markers;
  final MapsStatus mapsStatus;

  MapsState({
    this.places,
    this.markers,
    this.mapsStatus = const InitialMapsStatus(),
  });

  MapsState copyWith({
    GoogleMapController? mapController,
    List<Place>? places,
    Set<Marker>? markers,
    MapsStatus? mapsStatus,
  }) {
    return MapsState(
      places: places ?? this.places,
      markers: markers ?? this.markers,
      mapsStatus: mapsStatus ?? this.mapsStatus,
    );
  }
}
