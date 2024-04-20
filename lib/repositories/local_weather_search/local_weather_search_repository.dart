import 'package:dio/dio.dart';

const _host = 'http://api.openweathermap.org/geo/1.0/direct?';
const _limit = '&limit=5';
const _appID = '&appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class LocalWeatherSearchRepository {
  static Future<List<String>> getLocalWeatherSearch(
      {required String query}) async {
    final url = '${_host}q=$query,804$_limit$_appID$_apiKey';

    final response = await Dio().get(url);

    final data = response.data as List<dynamic>;

    final cityNameCountryList = data.map<String>((data) {
      final city = data['name'];
      final lat = data['lat'];
      final lon = data['lon'];
      final country = data['country'];
      return '$city, $country \nlat=$lat, lon=$lon';
    }).toList();
    // print(cityNameCountryList);

    return cityNameCountryList;
  }
}
