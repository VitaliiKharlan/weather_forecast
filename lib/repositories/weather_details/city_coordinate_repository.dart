import 'package:dio/dio.dart';
import 'models/city_coordinate.dart';

const _host = 'http://api.openweathermap.org/geo/1.0/direct?';
const _appID = '&appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class CityCoordinateRepository {
  Future<CityCoordinate> getCityCoordinate(String cityName) async {
    final url = '${_host}q=$cityName,804&limit=1$_appID$_apiKey';

    final response = await Dio().get(url);

    final data = response.data as List<dynamic>;
    final cityCoordinateList = data
        .map((dynamic e) => CityCoordinate.fromJson(e as Map<String, dynamic>))
        .toList();
    // print(cityCoordinateList);

    return cityCoordinateList.first;
  }
}
