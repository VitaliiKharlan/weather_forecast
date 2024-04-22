import 'package:flutter/material.dart';

import '../../../repositories/weather_details/city_coordinate_repository.dart';
import '../../../repositories/weather_details/models/city_coordinate.dart';

final cityController = CityController();

class CityController extends ChangeNotifier {
  final List<CityCoordinate> cities = [];

  final List<String> _cityNames = [];

  CityController();

  Future<void> fetchListOfCities() async {
    cities.clear();
    final repository = CityCoordinateRepository();
    for (final cityName in _cityNames) {
      final coordinates = await repository.getCityCoordinate(cityName);
      cities.add(coordinates);
    }
    notifyListeners();
  }

  void addNewCities(List<String> cities) {
    _cityNames.addAll(cities);
  }

  void addNewCity(String name) {
    _cityNames.add(name);

    fetchListOfCities();
  }

}
