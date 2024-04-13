import 'package:dio/dio.dart';
import 'models/weather_forecast_details.dart';

const _host = 'https://api.openweathermap.org/data/2.5/weather?';
const _units = 'units=metric&';
const _appID = 'appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

// // Kyiv
// const latCoord = 50.4500336;
// const lonCoord = 30.5241361;

// Lviv
// const lat = 'lat=49.841952&';
// const lon = 'lon=24.0315921&';

// final url = '$_host$lat$lon$_units$_appID$_apiKey';

class WeatherForecastDetailsRepository {
  Future<WeatherForecastDetails> getWeatherForecastDetails(
      double latCoord, double lonCoord) async {
    // right request
    // final response = await Dio().get('${_host}lat=50.4500336&lon=30.5241361&$_units$_appID$_apiKey');

    // right request
    final response = await Dio()
        .get('${_host}lat=$latCoord&lon=$lonCoord&$_units$_appID$_apiKey');

    // final response = await Dio().get('${_host}lat=latCoord&lon=lonCoord&$_units$_appID$_apiKey');

    final data = response.data as Map<String, dynamic>;

    final weatherForecastDetailsList = WeatherForecastDetails.fromJson(data);

    return weatherForecastDetailsList;
  }
}
