import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weathershmeather/repository/auth_repository.dart';

import 'landing_event.dart';
import 'landing_state.dart';
import 'landing_status.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  AuthRepository authRepo;
  LandingBloc({required this.authRepo}) : super(LandingState()) {
    const secureStorage = FlutterSecureStorage();
    on<LandingAwaitConnection>((event, emit) async {
      await Future.delayed(const Duration(seconds: 8));
      add(LandingLoadToken());
    });
    on<LandingLoadToken>((event, emit) async {
      try {
        ConnectivityResult connectivityResult =
            await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          final token = await secureStorage.read(key: 'token');
          final email = await secureStorage.read(key: 'email');
          if (token != null) {
            if (email != null) {
              final user = await authRepo.signInWithToken();
              emit(state.copyWith(formStatus: LandingAuthedWithMail(user)));
            } else {
              final signInAccount = await authRepo.googleSignIn();
              emit(state.copyWith(
                  formStatus: LandingAuthedWithGoogle(signInAccount)));
            }
          } else {
            emit(state.copyWith(formStatus: LandingNotAuthorized()));
          }
        } else {
          emit(state.copyWith(formStatus: NoConnection()));
          emit(state.copyWith(formStatus: const LandingInitialStatus()));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: LandingError(Exception(e))));
        emit(state.copyWith(formStatus: const LandingInitialStatus()));
      }
    });
  }
}
