import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weathershmeather/repository/maps_repository.dart';

import 'bloc/landing_bloc/landing_bloc.dart';
import 'repository/auth_repository.dart';
import 'bloc/maps_bloc/maps_bloc.dart';
import 'bloc/weather_bloc/weather_bloc.dart';
import 'pages/landing_screen.dart';
import 'styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => MapsRepository()),
        RepositoryProvider(create: (_) => AuthRepository()),
      ],
      child: SkeletonTheme(
        shimmerGradient: kShimmerGradient,
        darkShimmerGradient: kDarkShimmerGradient,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MapsBloc(mapsRepo: MapsRepository())),
            BlocProvider(
                create: (_) => LandingBloc(authRepo: AuthRepository())),
            BlocProvider(create: (_) => AuthBloc(authRepo: AuthRepository())),
            BlocProvider(create: (_) => WeatherBloc(mapsRepo: MapsRepository()))
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather-shmeather',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const LandingScreen(),
          ),
        ),
      ),
    );
  }
}
