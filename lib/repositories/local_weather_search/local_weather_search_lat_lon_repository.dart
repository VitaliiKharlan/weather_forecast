import 'package:dio/dio.dart';

import '../weather_details/models/weather_forecast_details.dart';

const _host = 'https://api.openweathermap.org/data/2.5/weather?';
const _units = 'units=metric&';
const _appID = 'appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class LocalWeatherSearchLatLonRepository {
  static Future<WeatherForecastDetails> getLocalWeatherSearchLatLon(
      {required double latCoord, required double lonCoord}) async {
    final response = await Dio()
        .get('${_host}lat=$latCoord&lon=$lonCoord&$_units$_appID$_apiKey');

    final data = await response.data as Map<String, dynamic>;

    final weatherForecastDetailsList = WeatherForecastDetails.fromJson(data);

    return weatherForecastDetailsList;
  }
}
