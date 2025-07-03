part of 'location_bloc.dart';

sealed class LocationEvent {}

// Evento para obtener la ubicación inicial del usuario
class InitialLocationEvent extends LocationEvent {}

// Evento para obtener actualizaciones de la posición del usuario
class StartTrackingUserEvent extends LocationEvent {}

// Evento para mostrar/ocultar la ruta del historial de ubicaciones
class ToggleShowLocationEvent extends LocationEvent {}
