import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_event.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_state.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_status.dart';

import '../../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository authRepo;
  AuthBloc({required this.authRepo}) : super(AuthState()) {
    on<AuthPhotoUrlChanged>((event, emit) async {
      if (event.result != null) {
        final path = event.result!.files.single.path;
        emit(state.copyWith(filePath: path, result: event.result));
      }
    });
    on<AuthDisplaynameChanged>((event, emit) {
      emit(state.copyWith(displayName: event.displayName));
    });
    on<AuthEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<AuthPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<AuthPasswordConfirimChanged>((event, emit) {
      emit(state.copyWith(confirimPassword: event.password));
    });
    on<AuthChangeType>((event, emit) {
      emit(state.copyWith(isLogin: event.loginType));
    });
    on<AuthPasswordIsObscure>((event, emit) {
      emit(state.copyWith(isObscure: event.isObscure));
    });
    on<AuthButtonStatus>((event, emit) {
      emit(state.copyWith(buttonStatus: event.buttonStatus));
    });
    on<AuthSubmit>((event, emit) async {
      emit(state.copyWith(formStatus: Submittion()));
      await Future.delayed(const Duration(seconds: 2));
      if (state.isLogin) {
        try {
          final auth = await authRepo.emailSignIn(state.email, state.password);
          final isExist = await authRepo.isExist(auth.user!.uid);
          if (isExist) {
            emit(state.copyWith(
                formStatus: SubmittionSuccessForMail(user: auth.user!)));
            await authRepo.saveToken(auth.user!.uid);
          } else {
            auth.user!.delete();
            emit(state.copyWith(formStatus: SubmittionError(Exception())));
          }
        } catch (e) {
          emit(state.copyWith(formStatus: SubmittionError(Exception(e))));
          emit(state.copyWith(formStatus: const InitialStatus()));
        }
      } else {
        try {
          final auth = await authRepo.emailSignUp(state.email, state.password);
          emit(state.copyWith(
              formStatus: SubmittionSuccessForMail(user: auth.user!)));
        } catch (e) {
          emit(state.copyWith(formStatus: SubmittionError(Exception(e))));
          emit(state.copyWith(formStatus: const InitialStatus()));
        }
      }
      emit(state.copyWith(buttonStatus: true));
    });
    on<GoogleSubmit>((event, emit) async {
      emit(state.copyWith(formStatus: Submittion()));
      await Future.delayed(const Duration(seconds: 2));
      try {
        final auth = await authRepo.googleSignIn();
        emit(state.copyWith(
            formStatus: SubmittionSuccessForGoogle(signInAccount: auth)));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmittionError(Exception(e))));
        emit(state.copyWith(formStatus: const InitialStatus()));
      }
      emit(state.copyWith(buttonStatus: true));
    });
    on<AuthSignOut>((event, emit) {
      try {
        final auth = FirebaseAuth.instance.currentUser!.email;
        if (event.auth == auth) {
          authRepo.signOutfromEmail();
        } else {
          authRepo.signOutFromGoogle();
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmittionError(Exception(e))));
        emit(state.copyWith(formStatus: const InitialStatus()));
      }
    });
  }
}
