import 'package:flutter/material.dart';

import '../../constants/lat_lon.dart';
import '../../../repositories/weather_details/air_pollution_repository.dart';
import '../../../repositories/weather_details/models/air_pollution_details.dart';

class AirPollutionController extends ChangeNotifier {
  final List<LatLon> cities;

  final List<AirPollutionDetails> airPollutionDetails = [];

  AirPollutionController({
    required this.cities,
  });

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
