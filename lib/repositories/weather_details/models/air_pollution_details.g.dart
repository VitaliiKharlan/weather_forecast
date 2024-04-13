// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_pollution_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirPollutionDetails _$AirPollutionDetailsFromJson(Map<String, dynamic> json) =>
    AirPollutionDetails(
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => ListPollutionDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirPollutionDetailsToJson(
        AirPollutionDetails instance) =>
    <String, dynamic>{
      'coord': instance.coord.toJson(),
      'list': instance.list.map((e) => e.toJson()).toList(),
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

ListPollutionDetails _$ListPollutionDetailsFromJson(
        Map<String, dynamic> json) =>
    ListPollutionDetails(
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
      dt: json['dt'] as int,
    );

Map<String, dynamic> _$ListPollutionDetailsToJson(
        ListPollutionDetails instance) =>
    <String, dynamic>{
      'main': instance.main.toJson(),
      'components': instance.components.toJson(),
      'dt': instance.dt,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      aqi: json['aqi'] as int,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'aqi': instance.aqi,
    };

Components _$ComponentsFromJson(Map<String, dynamic> json) => Components(
      co: (json['co'] as num).toDouble(),
      no: (json['no'] as num).toDouble(),
      no2: (json['no2'] as num).toDouble(),
      o3: (json['o3'] as num).toDouble(),
      so2: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      nh3: (json['nh3'] as num).toDouble(),
    );

Map<String, dynamic> _$ComponentsToJson(Components instance) =>
    <String, dynamic>{
      'co': instance.co,
      'no': instance.no,
      'no2': instance.no2,
      'o3': instance.o3,
      'so2': instance.so2,
      'pm2_5': instance.pm2_5,
      'pm10': instance.pm10,
      'nh3': instance.nh3,
    };
