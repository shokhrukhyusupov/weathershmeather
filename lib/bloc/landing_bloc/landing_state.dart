import 'landing_status.dart';

class LandingState {
  final LandingStatus formStatus;

  LandingState({
    this.formStatus = const LandingInitialStatus(),
  });

  LandingState copyWith({LandingStatus? formStatus}) {
    return LandingState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
