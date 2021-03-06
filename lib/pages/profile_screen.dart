import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weathershmeather/pages/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String email, uid, displayName;
  const ProfileScreen(
      {required this.email,
      required this.uid,
      required this.displayName,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _storage = FlutterSecureStorage();
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 35,
                backgroundImage:
                    AssetImage('assets/images/google_maps/unnamed.jpg')),
            const SizedBox(height: 15),
            Text(displayName),
            Text(email),
            Text(uid)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _storage.delete(key: 'token');
          _googleSignIn.signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AuthScreen()),
            (route) => false,
          );
        },
        child: const Icon(Icons.exit_to_app_outlined),
      ),
    );
  }
}
