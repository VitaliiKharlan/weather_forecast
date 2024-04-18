import 'package:flutter/material.dart';

import 'features/main/view/main_screen.dart';

class WeatherForecastApp extends StatelessWidget {
  final String? title;

  const WeatherForecastApp({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
