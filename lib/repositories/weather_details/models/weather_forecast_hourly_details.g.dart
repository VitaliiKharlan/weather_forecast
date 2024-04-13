// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_hourly_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecastHourlyDetails _$WeatherForecastHourlyDetailsFromJson(
        Map<String, dynamic> json) =>
    WeatherForecastHourlyDetails(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => ListHourlyDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherForecastHourlyDetailsToJson(
        WeatherForecastHourlyDetails instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list.map((e) => e.toJson()).toList(),
      'city': instance.city.toJson(),
    };

ListHourlyDetails _$ListHourlyDetailsFromJson(Map<String, dynamic> json) =>
    ListHourlyDetails(
      dt: json['dt'] as int,
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
      visibility: json['visibility'] as int,
      pop: (json['pop'] as num).toDouble(),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      dtTxt: DateTime.parse(json['dt_txt'] as String),
    );

Map<String, dynamic> _$ListHourlyDetailsToJson(ListHourlyDetails instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main.toJson(),
      'weather': instance.weather.map((e) => e.toJson()).toList(),
      'clouds': instance.clouds.toJson(),
      'wind': instance.wind.toJson(),
      'visibility': instance.visibility,
      'pop': instance.pop,
      'sys': instance.sys.toJson(),
      'dt_txt': instance.dtTxt.toIso8601String(),
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      seaLevel: json['sea_level'] as int,
      gindLevel: json['gind_level'] as int?,
      humidity: json['humidity'] as int,
      tempKf: (json['temp_kf'] as num).toDouble(),
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'sea_level': instance.seaLevel,
      'gind_level': instance.gindLevel,
      'humidity': instance.humidity,
      'temp_kf': instance.tempKf,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
      all: json['all'] as int,
    );

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: (json['gust'] as num).toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
      pod: json['pod'] as String,
    );

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'pod': instance.pod,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: json['id'] as int,
      name: json['name'] as String,
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      country: json['country'] as String,
      population: json['population'] as int,
      timezone: json['timezone'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coord.toJson(),
      'country': instance.country,
      'population': instance.population,
      'timezone': instance.timezone,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
