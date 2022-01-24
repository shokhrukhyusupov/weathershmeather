import 'package:file_picker/file_picker.dart';

abstract class AuthEvents {}

class AuthPhotoUrlChanged extends AuthEvents {}

class AuthDisplaynameChanged extends AuthEvents {
  final String displayName;

  AuthDisplaynameChanged({required this.displayName});
}

class AuthEmailChanged extends AuthEvents {
  final String email;
  AuthEmailChanged({required this.email});
}

class AuthPasswordChanged extends AuthEvents {
  final String password;
  AuthPasswordChanged({required this.password});
}

class AuthPasswordConfirimChanged extends AuthEvents {
  final String password;
  AuthPasswordConfirimChanged({required this.password});
}

class AuthChangeType extends AuthEvents {
  final bool loginType;
  AuthChangeType({required this.loginType});
}

class AuthPasswordIsObscure extends AuthEvents {
  final bool isObscure;

  AuthPasswordIsObscure({this.isObscure = true});
}

class AuthButtonStatus extends AuthEvents {
  final bool buttonStatus;

  AuthButtonStatus({required this.buttonStatus});
}

class AuthSubmit extends AuthEvents {}

class GoogleSubmit extends AuthEvents {}

class AuthSignOut extends AuthEvents {
  final String auth;

  AuthSignOut(this.auth);
}
