import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_event.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_state.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_status.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';

class DraggableBottomSheet extends StatelessWidget {
  final Animation<Offset> offset;
  const DraggableBottomSheet({required this.offset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(builder: (context, state) {
      if (state.mapsStatus is MapsLoadedSuccess) {
        List formattedAddress = (state.places![0].formattedAddress).split(', ');
        return SlideTransition(
          position: offset,
          child: DraggableScrollableSheet(
            initialChildSize: 0.26,
            maxChildSize: 0.88,
            minChildSize: 0.26,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(0),
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                        child: Container(
                          height: 4,
                          width: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.places![0].placeName,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 19),
                          ),
                          const SizedBox(height: 5),
                          for (var i = 0; i < formattedAddress.length; i++)
                            Column(
                              children: [
                                (Text(formattedAddress[i],
                                    style: const TextStyle(
                                        color: Colors.black54))),
                                const SizedBox(height: 5),
                              ],
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 15),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 42),
                            child: SizedBox(
                              width: 120,
                              child: FloatingActionButton.extended(
                                heroTag: '2',
                                onPressed: () {},
                                elevation: 0,
                                focusElevation: 2,
                                label: const Text('Маршрут'),
                                icon: const Icon(Icons.navigation, size: 20),
                                backgroundColor: Colors.blue[600],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 42),
                            child: SizedBox(
                              width: 130,
                              child: FloatingActionButton.extended(
                                heroTag: '3',
                                onPressed: () {
                                  BlocProvider.of<MapsBloc>(context)
                                      .add(SavePlace());
                                  BlocProvider.of<WeatherBloc>(context).add(
                                      WeatherCurrentPositionRequested(
                                          state.places![0].lat.toString(),
                                          state.places![0].lng.toString()));
                                  Navigator.pop(context);
                                },
                                elevation: 0,
                                focusElevation: 2,
                                label: Text('Сохранить',
                                    style: TextStyle(color: Colors.blue[600])),
                                icon: Icon(Icons.favorite_border,
                                    size: 20, color: Colors.blue[600]),
                                backgroundColor: Colors.white,
                                shape: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 42),
                            child: SizedBox(
                              width: 120,
                              child: FloatingActionButton.extended(
                                heroTag: '1',
                                onPressed: () {},
                                elevation: 0,
                                focusElevation: 2,
                                label: Text('Маршрут',
                                    style: TextStyle(color: Colors.blue[600])),
                                icon: Icon(Icons.trending_up,
                                    size: 20, color: Colors.blue[600]),
                                backgroundColor: Colors.white,
                                shape: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
