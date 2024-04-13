import 'package:json_annotation/json_annotation.dart';

part 'air_pollution_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AirPollutionDetails {
  AirPollutionDetails({
    required this.coord,
    required this.list,
  });

  final Coord coord;
  final List<ListPollutionDetails> list;

  factory AirPollutionDetails.fromJson(Map<String, dynamic> json) =>
      _$AirPollutionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AirPollutionDetailsToJson(this);

  @override
  String toString() {
    return 'AirPollutionDetails{'
        'coord: $coord, '
        'list: $list,'
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
class ListPollutionDetails {
  final Main main;
  final Components components;
  final int dt;

  ListPollutionDetails({
    required this.main,
    required this.components,
    required this.dt,
  });

  factory ListPollutionDetails.fromJson(Map<String, dynamic> json) =>
      _$ListPollutionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ListPollutionDetailsToJson(this);

  @override
  String toString() {
    return 'ListPollutionDetails{'
        'main: $main, '
        'components: $components, '
        'dt: $dt,'
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Main {
  final int aqi;

  Main({
    required this.aqi,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);

  @override
  String toString() {
    return 'Main{'
        'aqi: $aqi,'
        '}';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Components {
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;

  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) =>
      _$ComponentsFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentsToJson(this);

  @override
  String toString() {
    return 'Components{'
        'co: $co, '
        'no: $no, '
        'no2: $no2, '
        'o3: $o3, '
        'so2: $so2, '
        'pm2_5: $pm2_5, '
        'pm10: $pm10, '
        'nh3: $nh3,'
        '}';
  }
}
