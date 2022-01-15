import 'package:flutter/material.dart';
import 'package:weathershmeather/pages/home_screen.dart';
import 'package:weathershmeather/pages/profile_screen.dart';
import 'package:weathershmeather/pages/skeleton_home_screen.dart';

class HomeScreenAppbar extends StatefulWidget {
  final String email;
  final String uid, displayName;
  final String? photoUrl;
  const HomeScreenAppbar(
      {required this.email,
      required this.uid,
      required this.displayName,
      this.photoUrl,
      Key? key})
      : super(key: key);

  @override
  State<HomeScreenAppbar> createState() => _HomeScreenAppbarState();
}

class _HomeScreenAppbarState extends State<HomeScreenAppbar> {
  @override
  Widget build(BuildContext context) {
    final homeScreenState = context.findAncestorStateOfType<HomeScreenState>()!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: ElevatedButton(
                  onPressed: homeScreenState.isDrawerOpen
                      ? () {
                          homeScreenState.xOffset = 0;
                          homeScreenState.yOffset = 0;
                          homeScreenState.scaleFactor = 1;
                          homeScreenState.isDrawerOpen = false;
                          homeScreenState.setState(() {});
                        }
                      : () {
                          homeScreenState.xOffset = 180;
                          homeScreenState.yOffset = 100;
                          homeScreenState.scaleFactor = 0.7;
                          homeScreenState.isDrawerOpen = true;
                          homeScreenState.setState(() {});
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    primary: const Color(0xFFF7F7F7),
                    shadowColor: Colors.black.withOpacity(0.4),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Icon(
                    homeScreenState.isDrawerOpen
                        ? Icons.arrow_back_ios_new
                        : Icons.list,
                    color: const Color(0xFF1A1D26),
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 45,
                width: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SkeletonHomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    primary: const Color(0xFFF7F7F7),
                    shadowColor: Colors.black.withOpacity(0.4),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.notifications_none_rounded,
                      color: Color(0xFF1A1D26), size: 25),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      email: widget.email,
                      uid: widget.uid,
                      photoUrl: widget.photoUrl,
                      displayName: widget.displayName,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: Colors.blue,
                shadowColor: Colors.blue[800]!.withOpacity(0.4),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  const Icon(Icons.person, color: Color(0xFFF7F7F7), size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
