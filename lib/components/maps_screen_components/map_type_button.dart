import 'package:flutter/material.dart';
import 'package:weathershmeather/components/maps_screen_components/selection_map_type.dart';

class MapTypeButton extends StatelessWidget {
  final bool isTapped;
  const MapTypeButton(this.isTapped, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 450),
      top: isTapped ? 90 : 30,
      right: 10,
      child: SizedBox(
        width: 45,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => SelectionMapsType(context),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            primary: const Color(0xFFF7F7F7),
            shadowColor: Colors.blue.withOpacity(0.4),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child:
              const Icon(Icons.filter_none, color: Color(0xFF1A1D26), size: 20),
        ),
      ),
    );
  }
}
