import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_eela_2025/ui/core/map_style/map_style.dart';
import 'package:tracking_eela_2025/ui/map/bloc/location_bloc/location_bloc.dart';
import 'package:tracking_eela_2025/ui/map/bloc/map_cubit/map_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState() {
    super.initState();
    // context.read<LocationBloc>().add(InitialLocationEvent());
    // context.read<LocationBloc>().add(StartTrackingUserEvent());
    context.read<LocationBloc>()
      ..add(InitialLocationEvent())
      ..add(StartTrackingUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();
    final locationBloc = context.read<LocationBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.lastKnownLocation != null) {
              mapCubit.moveCamera(state.lastKnownLocation!);
            }
          },
          builder: (context, state) {
            if (state.lastKnownLocation == null) {
              // return Center(child: Text('Cargando ubi
              //cación ...'));
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return GoogleMap(
              style: jsonEncode(mapStyle),
              initialCameraPosition: CameraPosition(
                target: state.lastKnownLocation!,
                zoom: 18,
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                mapCubit.onMapInitialized(controller);
              },
              // circles: {
              //   Circle(
              //     circleId: CircleId('circle-1'),
              //     center: state.lastKnownLocation!,
              //     radius: 50,
              //     strokeWidth: 3,
              //     strokeColor: Colors.purple,
              //   )
              // },
              // polygons: {
              //   Polygon(
              //     polygonId: PolygonId('polygon-1'),
              //     points: [
              //       LatLng(-3.991765, -79.203404),
              //       LatLng(-3.992240, -79.203358),
              //       LatLng(-3.992190, -79.202456),
              //       LatLng(-3.991692, -79.202700),
              //     ],
              //     fillColor: Colors.purple.shade100,
              //     strokeWidth: 3,
              //     strokeColor: Colors.purple,
              //   )
              // },
              polylines: {
                Polyline(
                  polylineId: PolylineId('polyline-1'),
                  points: state.locationHistory,
                  color: Colors.purple,
                  width: 3,
                  visible: state.showLocationHistory,
                ),
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              locationBloc.add(ToggleShowLocationEvent());
            },
            child: Icon(Icons.more_vert),
          ),
          FloatingActionButton.small(
            onPressed: () {
              final lastKnownLocation = locationBloc
                  .state
                  .lastKnownLocation;
              if (lastKnownLocation == null) return;
              mapCubit.moveCamera(lastKnownLocation);
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
