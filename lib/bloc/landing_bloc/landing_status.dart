import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LandingStatus {
  const LandingStatus();
}

class LandingInitialStatus extends LandingStatus {
  const LandingInitialStatus();
}

class LandingAuthedWithMail extends LandingStatus {
  final User user;

  LandingAuthedWithMail(this.user);
}

class LandingAuthedWithGoogle extends LandingStatus {
  final GoogleSignInAccount signInAccount;

  LandingAuthedWithGoogle(this.signInAccount);
}

class LandingNotAuthorized extends LandingStatus {}

class NoConnection extends LandingStatus {}

class LandingError extends LandingStatus {
  Exception error;
  get geterror => error;
  LandingError(this.error);
}
