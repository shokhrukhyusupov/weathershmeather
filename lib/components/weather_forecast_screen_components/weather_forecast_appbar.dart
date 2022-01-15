import 'package:flutter/material.dart';

class WeatherForecastScreenAppBar extends StatelessWidget {
  const WeatherForecastScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF7F7F7),
                shadowColor: Colors.blue.withOpacity(0.4),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A1D26), size: 25),
            ),
          ),
          const Text(
            'Next 7 Days',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: Colors.blue,
                shadowColor: Colors.blue.withOpacity(0.4),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.person, color: Color(0xFFF7F7F7), size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
