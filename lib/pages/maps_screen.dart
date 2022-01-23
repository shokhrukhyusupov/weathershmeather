import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_event.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_state.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_status.dart';
import 'package:weathershmeather/components/maps_screen_components/draggable_bottom_sheet.dart';
import 'package:weathershmeather/components/maps_screen_components/map_type_button.dart';
import 'package:weathershmeather/components/maps_screen_components/places_search_bar.dart';
import 'package:weathershmeather/cubit/maps_type_cubit.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen>
    with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> completer = Completer();
  final FloatingSearchBarController searchController =
      FloatingSearchBarController();
  bool isTapped = true;
  late AnimationController animationController;
  late Animation<Offset> offsetSearchBar;
  late Animation<Offset> offsetBottomSheet;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    offsetSearchBar =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.2))
            .animate(animationController);
    offsetBottomSheet =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 0.3))
            .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (context, state) {
        if (state.mapsStatus is InitialMapsStatus) {
          return Scaffold(
            body: Image.asset(
              'assets/images/3d_weather_icons/01d.png',
              fit: BoxFit.cover,
            ),
          );
        } else if (state.mapsStatus is MapsLoadedSuccess) {
          return BlocBuilder<MapsTypeBloc, MapType>(
            builder: (context, mapType) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    GoogleMap(
                      mapType: mapType,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              state.places![0].lat, state.places![0].lng),
                          zoom: 12),
                      onMapCreated: (controller) =>
                          completer.complete(controller),
                      onLongPress: (position) async {
                        BlocProvider.of<MapsBloc>(context)
                            .add(MarkedLocation(position));
                        final mapController = await completer.future;
                        mapController
                            .animateCamera(CameraUpdate.newLatLng(position));
                      },
                      onTap: (_) {
                        setState(() {
                          isTapped = !isTapped;
                          isTapped
                              ? animationController.reverse()
                              : animationController.forward();
                        });
                      },
                      markers: state.markers != null ? state.markers! : {},
                    ),
                    MapTypeButton(isTapped),
                    DraggableBottomSheet(offset: offsetBottomSheet),
                    PlacesSearchBar(
                      offset: offsetSearchBar,
                      searchController: searchController,
                      completer: completer,
                      places: state.places!,
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state.mapsStatus is LoadingMaps) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.mapsStatus is MapsLoadFailed) {
          return const Center(
              child: Text('load failed', style: TextStyle(fontSize: 50)));
        } else {
          return const Center(
              child: Text('????', style: TextStyle(fontSize: 50)));
        }
      },
    );
  }
}
