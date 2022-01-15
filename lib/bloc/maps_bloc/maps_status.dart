abstract class MapsStatus {
  const MapsStatus();
}

class InitialMapsStatus extends MapsStatus {
  const InitialMapsStatus();
}

class LoadingMaps extends MapsStatus {}

class MapsLoadedSuccess extends MapsStatus {}

class MapsLoadFailed extends MapsStatus {
  final Exception exception;

  MapsLoadFailed(this.exception);
}
