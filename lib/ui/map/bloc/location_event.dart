part of 'location_bloc.dart';

sealed class LocationEvent {}

// Evento para obtener la ubicación inicial del usuario
class InitialLocationEvent extends LocationEvent {}
