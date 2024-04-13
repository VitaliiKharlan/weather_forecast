import 'package:flutter/material.dart';

import '../../constants/cities_coordinates.dart';
import '../../constants/lat_lon.dart';
import '../../../repositories/weather_details/air_pollution_repository.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';



class AirPollutionController extends ChangeNotifier {
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

  final List<AirPollutionDetails> airPollutionDetails = [];

  Future<void> init() async {
    final repository = AirPollutionRepository();
    for (final city in cities) {
      final coordinatesLatLon =
          await repository.getAirPollutionDetails(city.lat, city.lon);
      airPollutionDetails.add(coordinatesLatLon);
    }
    notifyListeners();
  }
}
