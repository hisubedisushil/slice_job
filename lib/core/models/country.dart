import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    final String? id,
    final String? shortname,
    final String? name,
    final String? countryCode,
    final String? status,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
class City with _$City {
  const factory City({
    final String? id,
    final String? name,
    final String? countryId,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
}
