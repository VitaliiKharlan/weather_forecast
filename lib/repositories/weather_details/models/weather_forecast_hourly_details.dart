import 'package:json_annotation/json_annotation.dart';

part 'weather_forecast_hourly_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WeatherForecastHourlyDetails {
  WeatherForecastHourlyDetails({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  final String cod;
  final int message;
  final int cnt;
  final List<ListHourlyDetails> list;
  final City city;

  factory WeatherForecastHourlyDetails.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastHourlyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastHourlyDetailsToJson(this);

  @override
  String toString() {
    return 'WeatherForecastHourlyDetails{'
        'cod: $cod, '
        'message: $message, '
        'cnt: $cnt, '
        'list: $list, '
        'city: $city, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ListHourlyDetails {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final DateTime dtTxt;

  ListHourlyDetails({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ListHourlyDetails.fromJson(Map<String, dynamic> json) =>
      _$ListHourlyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ListHourlyDetailsToJson(this);

  @override
  String toString() {
    return 'ListHourlyDetails{'
        'dt: $dt, '
        'main: $main, '
        'weather: $weather, '
        'clouds: $clouds, '
        'wind: $wind, '
        'visibility: $visibility, '
        'pop: $pop, sys: $sys, '
        'dtTxt: $dtTxt, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int? gindLevel;
  final int humidity;
  final double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.gindLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);

  @override
  String toString() {
    return 'Main{'
        'temp: $temp, '
        'feelsLike: $feelsLike, '
        'tempMin: $tempMin, '
        'tempMax: $tempMax, '
        'pressure: $pressure, '
        'seaLevel: $seaLevel, '
        'gindLevel: $gindLevel, '
        'humidity: $humidity, '
        'tempKf: $tempKf, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  String toString() {
    return 'Weather{'
        'id: $id, '
        'main: $main, '
        'description: $description, '
        'icon: $icon,'
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);

  @override
  String toString() {
    return 'Clouds{'
        'all: $all ,'
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);

  @override
  String toString() {
    return 'Wind{'
        'speed: $speed, '
        'deg: $deg, '
        'gust: $gust, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Sys {
  final String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);

  @override
  String toString() {
    return 'Sys{'
        'pod: $pod, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  String toString() {
    return 'City{'
        'id: $id, '
        'name: $name, '
        'coord: $coord, '
        'country: $country, '
        'population: $population, '
        'timezone: $timezone, '
        'sunrise: $sunrise, '
        'sunset: $sunset, '
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);

  @override
  String toString() {
    return 'Coord{'
        'lon: $lon, '
        'lat: $lat '
        '}';
  }
}
