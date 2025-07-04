part of 'location_bloc.dart';

class LocationState {
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  final bool showLocationHistory;
  final double speed;
  final double distance;

  LocationState({
    this.lastKnownLocation, 
    this.locationHistory = const [],
    this.showLocationHistory = true,
    this.speed = 0.0,
    this.distance = 0.0,
  });

  // Velocidad en Km/h
  double get speedInKm => speed * 3.6;

  // Distancia en Km
  double get distanceInKm => distance / 1000;

  // Kcal estimadas
  double get kcal => 1.03 * distanceInKm * 70;

  LocationState copyWith({
    LatLng? lastKnownLocation,
    List<LatLng>? locationHistory,
    bool? showLocationHistory,
    double? speed,
    double? distance,
  }) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      locationHistory: locationHistory ?? this.locationHistory,
      showLocationHistory: showLocationHistory ?? this.showLocationHistory,
      speed: speed ?? this.speed,
      distance: distance ?? this.distance,
    );
  }
}
