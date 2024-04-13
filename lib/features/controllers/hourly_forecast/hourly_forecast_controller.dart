import 'package:flutter/material.dart';

import '../../../repositories/weather_details/models/weather_forecast_hourly_details.dart';
import '../../../repositories/weather_details/weather_forecast_hourly_details_repository.dart';
import '../../constants/cities_coordinates.dart';
import '../../constants/lat_lon.dart';

class HourlyForecastController extends ChangeNotifier {
  final List<LatLon> cities = [
    LatLon(
        lat: CitiesCoordinates.latOfKyivUA, lon: CitiesCoordinates.lonOfKyivUA),
    LatLon(
        lat: CitiesCoordinates.latOfLvivUA, lon: CitiesCoordinates.lonOfLvivUA),
    LatLon(
        lat: CitiesCoordinates.latOfOdessaUA,
        lon: CitiesCoordinates.lonOfOdessaUA),
  ];

  final List<WeatherForecastHourlyDetails> weatherForecastHourlyDetails = [];

  Future<void> init() async {
    final repository = WeatherForecastHourlyDetailsRepository();
    for (final city in cities) {
      final coordinatesLatLon =
          await repository.getWeatherForecastHourlyDetails(city.lat, city.lon);
      weatherForecastHourlyDetails.add(coordinatesLatLon);
    }
    notifyListeners();
  }
}
