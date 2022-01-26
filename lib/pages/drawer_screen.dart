import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_event.dart';
import 'package:weathershmeather/cubit/maps_type_cubit.dart';
import 'package:weathershmeather/pages/auth_screen.dart';
import 'package:weathershmeather/pages/choosing_city.dart';
import 'package:weathershmeather/pages/maps_screen.dart';

class DrawerScreen extends StatelessWidget {
  final String displayName, email;
  final String? photoUrl;
  const DrawerScreen(
      {required this.displayName, required this.email, this.photoUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/3d_weather_icons/bgckdrawer1.jpg',
              width: 140,
              height: 140,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      photoUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(photoUrl!),
                              radius: 30)
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Icon(Icons.person,
                                  color: Colors.white, size: 28)),
                      const SizedBox(height: 15),
                      Text(displayName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(email,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChoosingCity()),
                    );
                  },
                  leading: const Icon(Icons.location_city_rounded,
                      color: Color(0xFF5897FD)),
                  minLeadingWidth: 0,
                  title: const Text('Choosing city',
                      style: TextStyle(fontSize: 14)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.new_label_rounded,
                      color: Color(0xFF5897FD)),
                  minLeadingWidth: 0,
                  title: const Text('Weather News',
                      style: TextStyle(fontSize: 14)),
                ),
                ListTile(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthSignOut(email));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  leading: const Icon(Icons.exit_to_app_rounded,
                      color: Color(0xFF5897FD)),
                  minLeadingWidth: 0,
                  title: const Text('Sign out', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/images/3d_weather_icons/bgckdrawer2.jpg',
                width: 160,
                height: 160,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0, left: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 40,
                width: 115,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xFFB0A4FF),
                      Color(0xFF806EF8),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 7),
                        color: const Color(0xFFB0A4FF).withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: Colors.transparent),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.settings),
                        SizedBox(width: 5),
                        Text("Settings")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
