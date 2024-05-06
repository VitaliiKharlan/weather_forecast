// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CitySearchResult _$CitySearchResultFromJson(Map<String, dynamic> json) =>
    CitySearchResult(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
    );

Map<String, dynamic> _$CitySearchResultToJson(CitySearchResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'country': instance.country,
    };
