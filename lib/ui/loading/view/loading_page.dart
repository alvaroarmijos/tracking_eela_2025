import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_eela_2025/ui/gps/bloc/gps_bloc.dart';
import 'package:tracking_eela_2025/ui/gps/view/gps_page.dart';
import 'package:tracking_eela_2025/ui/map/view/map_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        if (state.isAllEnable) {
          return const MapPage();
        }
        return const GpsPage();
      },
    );
  }
}
