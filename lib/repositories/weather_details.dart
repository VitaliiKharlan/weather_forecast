import 'weather_details/models/air_pollution_details.dart';
import 'weather_details/models/city_coordinate.dart';
import 'weather_details/models/weather_forecast_hourly_details.dart';
import 'weather_details/models/weather_forecast_details.dart';

class WeatherDetails {
  final DateTime addedAt;
  final CityCoordinate cityCoordinates;
  final WeatherForecastDetails weatherForecastDetails;
  final WeatherForecastHourlyDetails weatherForecastHourlyDetails;
  final AirPollutionDetails airPollutionDetails;

  WeatherDetails(
      {required this.addedAt,
        required this.cityCoordinates,
        required this.weatherForecastDetails,
        required this.weatherForecastHourlyDetails,
        required this.airPollutionDetails});
}