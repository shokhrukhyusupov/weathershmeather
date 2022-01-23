import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathershmeather/models/place.dart';

abstract class MapsEvent {
  const MapsEvent();
}

class InitialLocationRequest extends MapsEvent {}

class SelectedLocationRequested extends MapsEvent {
  final String? place;

  SelectedLocationRequested(this.place);
}

class MarkedLocation extends MapsEvent {
  final LatLng position;

  MarkedLocation(this.position);
}

class AddPlace extends MapsEvent {
  final Place place;

  AddPlace({required this.place});
}

class SavePlace extends MapsEvent {}

class FetchCurrentLocation extends MapsEvent {}

class TrackingCurrentLocation extends MapsEvent {}
