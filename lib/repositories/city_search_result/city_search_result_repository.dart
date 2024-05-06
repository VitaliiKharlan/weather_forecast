import 'package:dio/dio.dart';

import 'models/city_search_result.dart';

const _host = 'https://api.openweathermap.org/data/2.5/weather?';
const _limit = '&limit=5';
const _appID = 'appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class CitySearchResultRepository {
  static Future<List<CitySearchResult>> getCitySearchResult(
      {required String query}) async {
    final response =
        await Dio().get('${_host}q=$query,804$_limit$_appID$_apiKey');

    final data = await response.data as List<dynamic>;
    final citySearchResult = data
        .map(
            (dynamic e) => CitySearchResult.fromJson(e as Map<String, dynamic>))
        .toList();

    // print(citySearchResult);
    return citySearchResult;
  }
}
