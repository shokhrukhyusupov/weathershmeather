import 'package:file_picker/file_picker.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_status.dart';

class AuthState {
  final FilePickerResult? result;
  final String? filePath;
  final String displayName;
  final String email;
  final String password;  
  final String confirimPassword;
  final bool isLogin;
  final bool isObscure;
  final bool buttonStatus;
  final FormSubmittionStatus formStatus;

  get validateDisplayName => RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(displayName);

  get validatePassword => password.length >= 6;

  get validateMail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  get validateConfirimPassword => password == confirimPassword;

  AuthState({
    this.result,
    this.filePath,
    this.displayName = '',
    this.email = '',
    this.password = '',
    this.confirimPassword = '',
    this.isLogin = true,
    this.isObscure = true,
    this.buttonStatus = true,
    this.formStatus = const InitialStatus(),
  });
  AuthState copyWith({
    FilePickerResult? result,
    String? filePath,
    String? displayName,
    String? email,
    String? password,
    String? confirimPassword,
    bool? isLogin,
    bool? isObscure,
    bool? buttonStatus,
    FormSubmittionStatus? formStatus,
  }) {
    return AuthState(
      result: result ?? this.result,
      filePath: filePath ?? this.filePath,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirimPassword: confirimPassword ?? this.confirimPassword,
      isLogin: isLogin ?? this.isLogin,
      isObscure: isObscure ?? this.isObscure,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
