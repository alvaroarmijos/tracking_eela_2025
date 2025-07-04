import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<InitialLocationEvent>(_onInitialLocationEvent);
    on<StartTrackingUserEvent>(_onStartTrackingUserEvent);
    on<ToggleShowLocationEvent>(_onToggleShowLocationEvent);
  }

  FutureOr<void> _onInitialLocationEvent(InitialLocationEvent event, Emitter<LocationState> emit) async {
    final position = await Geolocator.getCurrentPosition();
      final latLang = LatLng(position.latitude, position.longitude);
    final speed = position.speed;
    emit(state.copyWith(lastKnownLocation: latLang, speed: speed));
  }

  FutureOr<void> _onStartTrackingUserEvent(StartTrackingUserEvent event, Emitter<LocationState> emit) {
    return emit.forEach(Geolocator.getPositionStream(), 
    onData: (position){
      final latLang = LatLng(position.latitude, position.longitude);
        // (lat4, long4)

        // [(lat1, long1), (lat2, long2), (lat3, long3), ]
      final newHistory = [...state.locationHistory, latLang];
        final speed = position.speed;
        final lenght = newHistory.length;

        // [(lat1, long1), (lat2, long2), (lat3, long3), (lat4, long4)]
        double currentDistance = 0;

        if (lenght > 1) {
          currentDistance = Geolocator.distanceBetween(
            newHistory[lenght - 2].latitude,
            newHistory[lenght - 2].longitude,
            position.latitude,
            position.longitude,
          );
        } 

      return state.copyWith(
        lastKnownLocation: latLang,
        locationHistory: newHistory,
          speed: speed,
          distance: state.distance + currentDistance
        );
    }
    );

  }

  FutureOr<void> _onToggleShowLocationEvent(ToggleShowLocationEvent event, Emitter<LocationState> emit) {
     emit(state.copyWith(
      showLocationHistory: !state.showLocationHistory
     ));
  }
}
