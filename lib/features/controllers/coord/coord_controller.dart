import 'package:flutter/material.dart';
import 'package:weather_forecast/repositories/weather_details/local_weather_search_lat_lon_repository.dart';

import '../../constants/lat_lon.dart';
import '../../../repositories/weather_details/models/weather_forecast_details.dart';
import '../../../repositories/weather_details/weather_forecast_details_repository.dart';

class CoordController extends ChangeNotifier {
  final List<LatLon> cities;

  // = [
  //   LatLon(
  //       lat: CitiesCoordinates.latOfKyivUA,
  //       lon: CitiesCoordinates.lonOfKyivUA),
  //   LatLon(
  //       lat: CitiesCoordinates.latOfLvivUA,
  //       lon: CitiesCoordinates.lonOfLvivUA),
  //   LatLon(
  //       lat: CitiesCoordinates.latOfOdessaUA,
  //       lon: CitiesCoordinates.lonOfOdessaUA),
  // ];

  final List<WeatherForecastDetails> details = [];

  CoordController({
    required this.cities,
  });

  Future<void> init() async {
    final repositoryWFDR = WeatherForecastDetailsRepository();
    final repositoryLWSLLR = LocalWeatherSearchLatLonRepository();

    for (final city in cities) {
      final coordinatesLatLonWFDR =
          await repositoryWFDR.getWeatherForecastDetails(city.lat, city.lon);
      details.add(coordinatesLatLonWFDR);

      // add it
      //
      final coordinatesLatLonLWSLLR =
          await LocalWeatherSearchLatLonRepository.getLocalWeatherSearchLatLon(
              latCoord: city.lat, lonCoord: city.lon);
      details.add(coordinatesLatLonLWSLLR);
    }
    notifyListeners();
  }

// Future<void> init() async {
//   final repository = LocalWeatherSearchLatLonRepository();
//   for (final city in cities) {
//     final coordinatesLatLon =
//     await repository.getLocalWeatherSearchLatLon(city.lat, city.lon);
//     details.add(coordinatesLatLon);
//   }
//   notifyListeners();
// }
}
