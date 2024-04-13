import 'package:json_annotation/json_annotation.dart';

part 'weather_forecast_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WeatherForecastDetails {
  WeatherForecastDetails({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory WeatherForecastDetails.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastDetailsToJson(this);

  @override
  String toString() {
    return 'WeatherForecastDetails{'
        'coord: $coord, '
        'weather: $weather, '
        'base: $base, '
        'main: $main, '
        'visibility: $visibility, '
        'wind: $wind, '
        'clouds: $clouds, '
        'dt: $dt, '
        'sys: $sys, '
        'timezone: $timezone, '
        'id: $id, '
        'name: $name, '
        'cod: $cod, '
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
class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
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
        'humidity: $humidity, '
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
class Sys {
  final int? type;
  final double? id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);

  @override
  String toString() {
    return 'Sys{'
        'type: $type, '
        'id: $id, '
        'country: $country, '
        'sunrise: $sunrise, '
        'sunset: $sunset, '
        '}';
  }
}
