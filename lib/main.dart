import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
        BlocProvider(create: (context) => MapsBloc()),
      ],
      child: Builder(builder: (context) {
        return RepositoryProvider(
          create: (_) => AuthRepository(),
          child: SkeletonTheme(
            shimmerGradient: kShimmerGradient,
            darkShimmerGradient: kDarkShimmerGradient,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather-shmeather',
              theme: ThemeData(primarySwatch: Colors.blue),
              home: BlocProvider(
                create: (context) => LandingBloc(authRepo: AuthRepository()),
                child: const LandingScreen(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
