import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/landing_bloc/landing_bloc.dart';
import 'package:weathershmeather/bloc/landing_bloc/landing_event.dart';
import 'package:weathershmeather/bloc/landing_bloc/landing_state.dart';
import 'package:weathershmeather/bloc/landing_bloc/landing_status.dart';
import 'package:weathershmeather/pages/home_screen.dart';
import 'package:weathershmeather/pages/auth_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    context.read<LandingBloc>().add(LandingLoadToken());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LandingBloc, LandingState>(
        listener: (context, state) {
          final _formstatus = state.formStatus;
          if (_formstatus is LandingAuthedWithMail) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  email: _formstatus.user.email!,
                  uid: _formstatus.user.uid,
                  displayName: _formstatus.user.displayName!,
                ),
              ),
              (route) => false,
            );
          } else if (_formstatus is LandingAuthedWithGoogle) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  email: _formstatus.signInAccount.email,
                  uid: _formstatus.signInAccount.id,
                  displayName: _formstatus.signInAccount.displayName!,
                ),
              ),
              (route) => false,
            );
          } else if (_formstatus is LandingNotAuthorized) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()),
              (route) => false,
            );
          } else if (_formstatus is NoConnection) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text(
                      'No network connection, \nplease check your connection'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text('exit', style: TextStyle(fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<LandingBloc>()
                            .add(LandingAwaitConnection());
                        Navigator.pop(context);
                      },
                      child: const Text('reconnecting',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Image.asset('assets/images/3d_weather_icons/01d.png'),
            ),
            const SizedBox(height: 30),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Weather ',
                      style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(text: 'Shmeather')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
