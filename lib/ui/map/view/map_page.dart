import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_eela_2025/ui/map/bloc/location_bloc.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? googleMapController;

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(InitialLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state.lastKnownLocation == null) {
              // return Center(child: Text('Cargando ubi
              //cación ...'));
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: state.lastKnownLocation!,
                zoom: 18,
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {},
            child: Icon(Icons.more_vert),
          ),
          FloatingActionButton.small(
            onPressed: () {
              final lastKnownLocation = context
                  .read<LocationBloc>()
                  .state
                  .lastKnownLocation;
              if (lastKnownLocation == null) return;
              googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: lastKnownLocation, zoom: 18),
                ),
              );
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
