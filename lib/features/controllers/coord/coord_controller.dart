import 'package:flutter/material.dart';

import '../../constants/cities_coordinates.dart';
import '../../constants/lat_lon.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../../repositories/weather_details/weather_forecast_details_repository.dart';

class CoordController extends ChangeNotifier {
  final List<LatLon> cities = [
    LatLon(
        lat: CitiesCoordinates.latOfKyivUA,
        lon: CitiesCoordinates.lonOfKyivUA),
    LatLon(
        lat: CitiesCoordinates.latOfLvivUA,
        lon: CitiesCoordinates.lonOfLvivUA),
    LatLon(
        lat: CitiesCoordinates.latOfOdessaUA,
        lon: CitiesCoordinates.lonOfOdessaUA),
  ];

  final List<WeatherForecastDetails> details = [];

  Future<void> init() async {
    final repository = WeatherForecastDetailsRepository();
    for (final city in cities) {
      final coordinatesLatLon =
          await repository.getWeatherForecastDetails(city.lat, city.lon);
      details.add(coordinatesLatLon);
    }
    notifyListeners();
  }
}
