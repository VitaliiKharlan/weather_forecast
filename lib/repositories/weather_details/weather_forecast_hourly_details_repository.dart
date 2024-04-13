import 'package:dio/dio.dart';

import 'models/weather_forecast_hourly_details.dart';


const _host = 'https://api.openweathermap.org/data/2.5/forecast?';
const _units = 'units=metric&';
const _cnt = 'cnt=24&';
const _appID = '&appid=';
const _apiKey = '4dbe24134496b55a1b13855ddf7c5847';

class WeatherForecastHourlyDetailsRepository {
  Future<WeatherForecastHourlyDetails> getWeatherForecastHourlyDetails(
      double latCoord, double lonCoord) async {
    final response =
    await Dio().get('${_host}lat=$latCoord&lon=$lonCoord&$_units$_cnt$_appID$_apiKey');
    // final response = await Dio().get(
    //     'http://api.openweathermap.org/data/2.5/air_pollution?'
    //         'lat=50.4500336&'
    //         'lon=30.5241361&'
    //         'appid='
    //         '4dbe24134496b55a1b13855ddf7c5847');

    // final data = response.data as Map<String, dynamic>;
    final data = response.data as Map<String, dynamic>;

    // final airPollutionList = AirPollution.fromJson(data);
    // final airPollutionList = AirPollution.fromJson(data);
    final weatherForecastHourlyDetailsList =  WeatherForecastHourlyDetails.fromJson(data);
    // print(weatherForecastHourlyDetailsList);

    return weatherForecastHourlyDetailsList;
  }
}
