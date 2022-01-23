class Place {
  final String formattedAddress;
  final String placeName;
  final double lat;
  final double lng;

  Place({
    required this.formattedAddress,
    required this.placeName,
    required this.lat,
    required this.lng,
  });

  factory Place.fromMap(map) {
    return Place(
      formattedAddress: map['formatted_address'],
      placeName: map['name'],
      lat: map['geometry']['location']['lat'],
      lng: map['geometry']['location']['lng'],
    );
  }
}