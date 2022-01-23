import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_event.dart';
import 'package:weathershmeather/models/place.dart';

class PlacesSearchBar extends StatelessWidget {
  final Animation<Offset> offset;
  final FloatingSearchBarController searchController;
  final Completer<GoogleMapController> completer;
  final List<Place> places;
  const PlacesSearchBar(
      {required this.offset,
      required this.searchController,
      required this.completer,
      required this.places,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SlideTransition(
      position: offset,
      child: FloatingSearchBar(
        controller: searchController,
        hint: 'Search for a new Place...',
        iconColor: Colors.black54,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        borderRadius: BorderRadius.circular(12),
        debounceDelay: const Duration(milliseconds: 500),
        onSubmitted: (query) {
          BlocProvider.of<MapsBloc>(context)
              .add(SelectedLocationRequested(searchController.query));
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.gps_fixed),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 0,
              maxHeight: 490,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: places.isEmpty ? Colors.transparent : Colors.white,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: places.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(places[i].placeName),
                  subtitle: Text(places[i].formattedAddress),
                  onTap: () async {
                    final mapController = await completer.future;
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(places[i].lat, places[i].lng),
                          zoom: 12,
                        ),
                      ),
                    );
                    BlocProvider.of<MapsBloc>(context)
                        .add(AddPlace(place: places[i]));
                    FloatingSearchBar.of(context)!.close();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
