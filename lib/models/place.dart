import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String country;
  final String city;
  final String name;
  final LatLng latLng;

  Place({
    required this.country,
    required this.city,
    required this.name,
    required this.latLng,
  });

  factory Place.fromMap(map) {
    List formattedAddress = (map['formatted_address'] as String).split(',');
    bool length = formattedAddress.length == 3;
    return Place(
      country: length ? formattedAddress[2] : formattedAddress[1],
      city: length ? formattedAddress[1] : formattedAddress[0],
      name: map['name'] ?? (length ? formattedAddress[0] : '-'),
      latLng: LatLng(
        map['geometry']['location']['lat'],
        map['geometry']['location']['lng'],
      ),
    );
  }
}