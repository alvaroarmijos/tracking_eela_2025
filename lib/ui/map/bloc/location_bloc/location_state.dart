part of 'location_bloc.dart';

class LocationState {
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  final bool showLocationHistory;

  LocationState({
    this.lastKnownLocation, 
    this.locationHistory = const [],
    this.showLocationHistory = true,
  });

  LocationState copyWith({
  LatLng? lastKnownLocation, 
  List<LatLng>? locationHistory,
  bool? showLocationHistory,
  }) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      locationHistory: locationHistory ?? this.locationHistory,
      showLocationHistory: showLocationHistory ?? this.showLocationHistory,
    );
  }
}
