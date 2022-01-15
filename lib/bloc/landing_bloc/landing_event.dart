abstract class LandingEvent {
  const LandingEvent();
}

class LandingLoadToken extends LandingEvent {}

class LandingAwaitConnection extends LandingEvent {}
