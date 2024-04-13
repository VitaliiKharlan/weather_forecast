// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_coordinate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityCoordinate _$CityCoordinateFromJson(Map<String, dynamic> json) =>
    CityCoordinate(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
    );

Map<String, dynamic> _$CityCoordinateToJson(CityCoordinate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'country': instance.country,
    };
