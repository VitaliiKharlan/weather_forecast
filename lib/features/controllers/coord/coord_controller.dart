import 'package:flutter/material.dart';

import '../../constants/lat_lon.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../../repositories/weather_details/weather_forecast_details_repository.dart';

class CoordController extends ChangeNotifier {
  final List<LatLon> cities;

  final List<WeatherForecastDetails> details = [];

  CoordController({
    required this.cities,
  });

  Future<void> init() async {
    final repositoryWFDR = WeatherForecastDetailsRepository();

    for (final city in cities) {
      final coordinatesLatLonWFDR =
          await repositoryWFDR.getWeatherForecastDetails(city.lat, city.lon);
      details.add(coordinatesLatLonWFDR);

      notifyListeners();
    }
  }
}
