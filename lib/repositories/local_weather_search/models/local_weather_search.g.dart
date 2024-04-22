// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_weather_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalWeatherSearch _$LocalWeatherSearchFromJson(Map<String, dynamic> json) =>
    LocalWeatherSearch(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
    );

Map<String, dynamic> _$LocalWeatherSearchToJson(LocalWeatherSearch instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'country': instance.country,
    };
