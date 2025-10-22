import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_eela_2025/data/routes/domain/place.dart';
import 'package:tracking_eela_2025/data/routes/domain/route.dart';

abstract class RoutesRepository {
  Future<Route?> getRouteStartToEnd(LatLng start, LatLng end);

  Future<List<Place>> searchPlace(String query, LatLng proximity);
}
