import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_status.dart';
import 'package:weathershmeather/models/place.dart';

class MapsState {
  final Place? place;
  final List<Place>? places;
  final String? lat;
  final String? lng;
  final Set<Marker>? markers;
  final MapsStatus mapsStatus;

  MapsState({
    this.place,
    this.places,
    this.lat,
    this.lng,
    this.markers,
    this.mapsStatus = const InitialMapsStatus(),
  });

  MapsState copyWith({
    Place? place,
    List<Place>? places,
    String? lat,
    String? lng,
    Set<Marker>? markers,
    MapsStatus? mapsStatus,
  }) {
    return MapsState(
      place: place ?? this.place,
      places: places ?? this.places,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      markers: markers ?? this.markers,
      mapsStatus: mapsStatus ?? this.mapsStatus,
    );
  }
}
