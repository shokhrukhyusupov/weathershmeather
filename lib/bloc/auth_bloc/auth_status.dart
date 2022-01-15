import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FormSubmittionStatus {
  const FormSubmittionStatus();
}

class InitialStatus extends FormSubmittionStatus {
  const InitialStatus();
}

class Submittion extends FormSubmittionStatus {}

class SubmittionSuccessForMail extends FormSubmittionStatus {
  final User user;
  SubmittionSuccessForMail({required this.user});
}

class SubmittionSuccessForGoogle extends FormSubmittionStatus {
  final GoogleSignInAccount signInAccount;
  SubmittionSuccessForGoogle({required this.signInAccount});
}

class SubmittionError extends FormSubmittionStatus {
  Exception error;
  get geterror => error;
  SubmittionError(this.error);
}
