import 'package:json_annotation/json_annotation.dart';

part 'city_coordinate.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CityCoordinate {
  CityCoordinate({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  final String name;
  final double lat;
  final double lon;
  final String country;

  factory CityCoordinate.fromJson(Map<String, dynamic> json) =>
      _$CityCoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CityCoordinateToJson(this);

  @override
  String toString() {
    return 'CityCoordinate{'
        'name: $name, '
        'lat: $lat, '
        'lon: $lon, '
        'country: $country'
        '}';
  }
}
