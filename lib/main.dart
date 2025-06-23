import 'package:flutter/material.dart';
import 'package:tracking_eela_2025/ui/core/theme/app_theme.dart';
import 'package:tracking_eela_2025/ui/gps/view/gps_page.dart';

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
      home: const GpsPage(),
      theme: AppTheme.light,
    );
  }
}
