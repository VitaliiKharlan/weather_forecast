import 'package:json_annotation/json_annotation.dart';

part 'local_weather_search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocalWeatherSearch {
  LocalWeatherSearch({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  final String name;
  final double lat;
  final double lon;
  final String country;

  factory LocalWeatherSearch.fromJson(Map<String, dynamic> json) =>
      _$LocalWeatherSearchFromJson(json);

  Map<String, dynamic> toJson() => _$LocalWeatherSearchToJson(this);

  @override
  String toString() {
    return 'LocalWeatherSearch{'
        'name: $name, '
        'lat: $lat, '
        'lon: $lon, '
        'country: $country'
        '}';
  }
}

