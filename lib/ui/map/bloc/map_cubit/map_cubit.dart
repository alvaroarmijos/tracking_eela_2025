import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_eela_2025/data/routes/domain/route.dart' as data;

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  GoogleMapController? _mapController;
  LatLng? mapCenter;

  // Inicializar el controlador del mapa
  void onMapInitialized(GoogleMapController controller) {
    _mapController = controller;
  }

  // Metodo para mover la camara a una posición espefica
  void moveCamera(LatLng target) {
    final cameraUpdate = CameraUpdate.newLatLng(target);
    _mapController?.animateCamera(cameraUpdate);
  }

  void addRoutePolyline(data.Route route) {
    final direction = Polyline(
      polylineId: const PolylineId('direction'),
      points: route.points,
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    // {
    // 'myRoute': Polyline1,
    // 'directions': Polyline2,
    // }

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['direction'] = direction;

    // {
    // 'myRoute': NewPolyline1,
    // 'directions': Polyline2,
    // }

    // Markers

    String distanceKm = (((route.distance ?? 0) / 1000)).toStringAsFixed(2);
    int time = ((route.duration ?? 0) / 60).toInt();
    // Google map markers
    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: route.points.first,
      infoWindow: InfoWindow(
        title: 'Punto de inicio',
        snippet: 'km $distanceKm',
      ),
    );
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: route.points.last,
      infoWindow: InfoWindow(
        title: 'Punto final',
        snippet: 'Tiempo: $time minutos',
      ),
    );

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    emit(state.copyWith(polylines: currentPolylines, markers: currentMarkers));
  }
}
