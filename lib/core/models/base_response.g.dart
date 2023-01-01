// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BaseResponse<T> _$$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$BaseResponse<T>(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$$BaseResponseToJson<T>(
  _$BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': toJsonT(instance.data),
    };

_$BaseResponsePaginated<T> _$$BaseResponsePaginatedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$BaseResponsePaginated<T>(
      status: json['status'] as bool,
      message: json['message'] as String,
      total: json['total'],
      page: json['page'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$$BaseResponsePaginatedToJson<T>(
  _$BaseResponsePaginated<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'status': instance.status,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total', instance.total);
  val['page'] = instance.page;
  val['data'] = toJsonT(instance.data);
  return val;
}

_$ResponseDataList<T> _$$ResponseDataListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ResponseDataList<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResponseDataListToJson<T>(
  _$ResponseDataList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'runtimeType': instance.$type,
    };

_$ResponseDataMap<T> _$$ResponseDataMapFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ResponseDataMap<T>(
      data: fromJsonT(json['data']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResponseDataMapToJson<T>(
  _$ResponseDataMap<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'runtimeType': instance.$type,
    };
