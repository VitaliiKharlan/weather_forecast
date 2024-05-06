import 'package:json_annotation/json_annotation.dart';

part 'city_search_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CitySearchResult {
  CitySearchResult({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  final String name;
  final double lat;
  final double lon;
  final String country;

  factory CitySearchResult.fromJson(Map<String, dynamic> json) =>
      _$CitySearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$CitySearchResultToJson(this);

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

