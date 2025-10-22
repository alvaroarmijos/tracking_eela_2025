import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_eela_2025/ui/core/utils/cutoms_markers.dart';
import 'package:tracking_eela_2025/ui/core/widgets/loading_dialog.dart';
import 'package:tracking_eela_2025/ui/map/bloc/cubit/search_cubit.dart';
import 'package:tracking_eela_2025/ui/map/bloc/location_bloc/location_bloc.dart';
import 'package:tracking_eela_2025/ui/map/bloc/map_cubit/map_cubit.dart';
import 'package:tracking_eela_2025/ui/map/view/manual_marker_page.dart';
import 'package:tracking_eela_2025/ui/map/widgets/floating_actions.dart';
import 'package:tracking_eela_2025/ui/map/widgets/map_section.dart';
import 'package:tracking_eela_2025/ui/map/widgets/search_bar_info.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BitmapDescriptor? bitmapDescriptor;
  BitmapDescriptor? bitmapDescriptorNetwork;

  @override
  void initState() {
    super.initState();
    // context.read<LocationBloc>().add(InitialLocationEvent());
    // context.read<LocationBloc>().add(StartTrackingUserEvent());
    context.read<LocationBloc>()
      ..add(InitialLocationEvent())
      ..add(StartTrackingUserEvent());

    initMarkers();
  }

  void initMarkers() async {
    bitmapDescriptor = await getAssetImageMarker();
    bitmapDescriptorNetwork = await getNetworkImageMarker();
  }

  @override
  Widget build(BuildContext context) {
    final mapCubit = context.read<MapCubit>();

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
            return Stack(
              children: [
                MapSection(lastKownLocation: state.lastKnownLocation!),
                BlocConsumer<SearchCubit, SearchState>(
                  listenWhen: (previous, current) =>
                      previous.isLoading != current.isLoading,
                  listener: _listenState,
                  builder: (context, state) {
                    return state.showManualMarker
                        ? const ManualMarker()
                        : const SearchBarInfo();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActions(),
    );
  }

  void _listenState(BuildContext context, SearchState state) {
    if (state.route != null && state.route?.points != null) {
      context.read<MapCubit>().addRoutePolyline(state.route!);
    }

    if (state.isLoading) {
      showLoadingMessage(context);
    } else {
      Navigator.pop(context);
    }
  }
}
