import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_eela_2025/ui/map/bloc/location_bloc/location_bloc.dart';

class RunningInfo extends StatelessWidget {
  const RunningInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RunningItem(
                    iconPath: 'assets/icons/running_icon.png',
                    value: state.distanceInKm,
                    label: 'Km',
                  ),
                  VerticalDivider(color: Colors.grey[300]),
                  RunningItem(
                    iconPath: 'assets/icons/fire_icon.png',
                    value: state.kcal,
                    label: 'Kcal',
                  ),
                  VerticalDivider(color: Colors.grey[300]),
                  RunningItem(
                    iconPath: 'assets/icons/velocity_icon.png',
                    value: state.speedInKm,
                    label: 'Km/h',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class RunningItem extends StatelessWidget {
  const RunningItem({
    super.key,
    required this.iconPath,
    required this.value,
    required this.label,
  });

  final String iconPath;
  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Image.asset(iconPath),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value.toStringAsFixed(2), style: textTheme.titleMedium),
            Text(label, style: textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
