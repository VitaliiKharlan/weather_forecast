import 'package:flutter/material.dart';
import 'package:weather_forecast/features/main/view/main_screen.dart';

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

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
