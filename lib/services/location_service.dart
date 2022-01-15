import 'dart:convert';

import 'package:weathershmeather/models/place.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static const String _apiKey = 'AIzaSyCWEzomGSwHkZrZvpaSDr0bW3zrKE-tEbg';

  static Future<List<Place>> getPlace(String address) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$address&key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<Place> place = (json['results'] as List<dynamic>)
          .map((item) => Place.fromMap(item))
          .toList();
      return place;
    } else {
      throw Exception('Failed to load location');
    }
  }
}