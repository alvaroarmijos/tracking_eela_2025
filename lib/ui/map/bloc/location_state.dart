part of 'location_bloc.dart';

class LocationState {
  final LatLng? lastKnownLocation;

  LocationState({this.lastKnownLocation});

  LocationState copyWith({LatLng? lastKnownLocation}) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    );
  }
}
