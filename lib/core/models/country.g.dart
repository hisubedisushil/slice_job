// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Country _$$_CountryFromJson(Map<String, dynamic> json) => _$_Country(
      id: json['id'] as String?,
      shortname: json['shortname'] as String?,
      name: json['name'] as String?,
      countryCode: json['country_code'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_CountryToJson(_$_Country instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('shortname', instance.shortname);
  writeNotNull('name', instance.name);
  writeNotNull('country_code', instance.countryCode);
  writeNotNull('status', instance.status);
  return val;
}

_$_City _$$_CityFromJson(Map<String, dynamic> json) => _$_City(
      id: json['id'] as String?,
      name: json['name'] as String?,
      countryId: json['country_id'] as String?,
    );

Map<String, dynamic> _$$_CityToJson(_$_City instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('country_id', instance.countryId);
  return val;
}
