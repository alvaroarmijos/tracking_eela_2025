import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_eela_2025/ui/core/theme/app_theme.dart';
import 'package:tracking_eela_2025/ui/gps/bloc/gps_bloc.dart';
import 'package:tracking_eela_2025/ui/loading/view/loading_page.dart';
import 'package:tracking_eela_2025/ui/map/bloc/location_bloc/location_bloc.dart';
import 'package:tracking_eela_2025/ui/map/bloc/map_cubit/map_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GpsBloc()
              ..add(GpsInitialStatusEvent())
              ..add(ChangeGpsStatusEvent()),
          ),
          BlocProvider(create: (context) => LocationBloc()),
          BlocProvider(create: (context) => MapCubit())
        ],
        child: const LoadingPage(),
      ),
      theme: AppTheme.light,
    );
  }
}
