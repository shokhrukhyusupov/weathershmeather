import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/cubit/maps_type_cubit.dart';

class SelectionMapsType extends StatelessWidget {
  final BuildContext ctx;
  const SelectionMapsType(this.ctx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Тип карты'),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Color(0xFF505050)),
                splashRadius: 0.1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            mapsTypeWidget(MapsTypeEvent.normal, 'normal', 'По умолчанию'),
            mapsTypeWidget(MapsTypeEvent.hybrid, 'hybrid', 'Спутник'),
            mapsTypeWidget(MapsTypeEvent.satellite, 'satellite', 'Рельеф'),
          ],
        ),
      ],
    );
  }

  GestureDetector mapsTypeWidget(
      MapsTypeEvent type, String name, String context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<MapsTypeBloc>(ctx).add(type),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(
              'assets/images/google_maps/$name.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 80,
            child: Text(
              context,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF616161),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
