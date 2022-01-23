import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/repository/auth_repository.dart';
import 'package:weathershmeather/pages/auth_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String displayName;
  final String? photoUrl;
  const VerifyScreen({required this.displayName, this.photoUrl, Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  int timerTick = 120;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVirified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        leading: IconButton(
          onPressed: () {
            user.delete();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RepositoryProvider(
                  create: (_) => AuthRepository(),
                  child: AuthScreen(),
                ),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
            'An email has been send to ${user.email}, please verify, $timerTick'),
      ),
    );
  }

  Future<void> checkEmailVirified() async {
    user = auth.currentUser!;
    await user.reload();
    setState(() => timerTick--);
    if (user.emailVerified) {
      timer.cancel();
      await user.updateDisplayName(widget.displayName);
      await user.updatePhotoURL(widget.photoUrl);
      await _users.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': widget.displayName,
        'photoUrl': widget.photoUrl,
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (_) => AuthRepository(),
            child: AuthScreen(),
          ),
        ),
        (route) => false,
      );
    }
    if (timer.tick >= 120) {
      timer.cancel();
      user.delete();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (_) => AuthRepository(),
            child: AuthScreen(),
          ),
        ),
        (route) => false,
      );
    }
  }
}
