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
      emit(state.copyWith(lastKnownLocation: latLang));
  }

  FutureOr<void> _onStartTrackingUserEvent(StartTrackingUserEvent event, Emitter<LocationState> emit) {
    return emit.forEach(Geolocator.getPositionStream(), 
    onData: (position){
      final latLang = LatLng(position.latitude, position.longitude);
      final newHistory = [...state.locationHistory, latLang];

      return state.copyWith(
        lastKnownLocation: latLang,
        locationHistory: newHistory,
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
