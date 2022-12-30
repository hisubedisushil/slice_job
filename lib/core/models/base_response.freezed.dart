// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiResponse<T> _$ApiResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return BaseResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ApiResponse<T> {
  bool get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) then) =
      _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
  @useResult
  $Res call({bool status, String message, T data});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseResponseCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$$BaseResponseCopyWith(
          _$BaseResponse<T> value, $Res Function(_$BaseResponse<T>) then) =
      __$$BaseResponseCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool status, String message, T data});
}

/// @nodoc
class __$$BaseResponseCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$BaseResponse<T>>
    implements _$$BaseResponseCopyWith<T, $Res> {
  __$$BaseResponseCopyWithImpl(
      _$BaseResponse<T> _value, $Res Function(_$BaseResponse<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$BaseResponse<T>(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$BaseResponse<T> implements BaseResponse<T> {
  const _$BaseResponse(
      {required this.status, required this.message, required this.data});

  factory _$BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$BaseResponseFromJson(json, fromJsonT);

  @override
  final bool status;
  @override
  final String message;
  @override
  final T data;

  @override
  String toString() {
    return 'ApiResponse<$T>(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseResponse<T> &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, message, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseResponseCopyWith<T, _$BaseResponse<T>> get copyWith =>
      __$$BaseResponseCopyWithImpl<T, _$BaseResponse<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$BaseResponseToJson<T>(this, toJsonT);
  }
}

abstract class BaseResponse<T> implements ApiResponse<T> {
  const factory BaseResponse(
      {required final bool status,
      required final String message,
      required final T data}) = _$BaseResponse<T>;

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$BaseResponse<T>.fromJson;

  @override
  bool get status;
  @override
  String get message;
  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$BaseResponseCopyWith<T, _$BaseResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

ResponseData<T> _$ResponseDataFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  switch (json['runtimeType']) {
    case 'list':
      return ResponseDataList<T>.fromJson(json, fromJsonT);
    case 'map':
      return ResponseDataMap<T>.fromJson(json, fromJsonT);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ResponseData',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ResponseData<T> {
  Object? get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> data) list,
    required TResult Function(T data) map,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> data)? list,
    TResult? Function(T data)? map,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> data)? list,
    TResult Function(T data)? map,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResponseDataList<T> value) list,
    required TResult Function(ResponseDataMap<T> value) map,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResponseDataList<T> value)? list,
    TResult? Function(ResponseDataMap<T> value)? map,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResponseDataList<T> value)? list,
    TResult Function(ResponseDataMap<T> value)? map,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseDataCopyWith<T, $Res> {
  factory $ResponseDataCopyWith(
          ResponseData<T> value, $Res Function(ResponseData<T>) then) =
      _$ResponseDataCopyWithImpl<T, $Res, ResponseData<T>>;
}

/// @nodoc
class _$ResponseDataCopyWithImpl<T, $Res, $Val extends ResponseData<T>>
    implements $ResponseDataCopyWith<T, $Res> {
  _$ResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ResponseDataListCopyWith<T, $Res> {
  factory _$$ResponseDataListCopyWith(_$ResponseDataList<T> value,
          $Res Function(_$ResponseDataList<T>) then) =
      __$$ResponseDataListCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> data});
}

/// @nodoc
class __$$ResponseDataListCopyWithImpl<T, $Res>
    extends _$ResponseDataCopyWithImpl<T, $Res, _$ResponseDataList<T>>
    implements _$$ResponseDataListCopyWith<T, $Res> {
  __$$ResponseDataListCopyWithImpl(
      _$ResponseDataList<T> _value, $Res Function(_$ResponseDataList<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ResponseDataList<T>(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResponseDataList<T> implements ResponseDataList<T> {
  const _$ResponseDataList({required final List<T> data, final String? $type})
      : _data = data,
        $type = $type ?? 'list';

  factory _$ResponseDataList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResponseDataListFromJson(json, fromJsonT);

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ResponseData<$T>.list(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseDataList<T> &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseDataListCopyWith<T, _$ResponseDataList<T>> get copyWith =>
      __$$ResponseDataListCopyWithImpl<T, _$ResponseDataList<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> data) list,
    required TResult Function(T data) map,
  }) {
    return list(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> data)? list,
    TResult? Function(T data)? map,
  }) {
    return list?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> data)? list,
    TResult Function(T data)? map,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResponseDataList<T> value) list,
    required TResult Function(ResponseDataMap<T> value) map,
  }) {
    return list(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResponseDataList<T> value)? list,
    TResult? Function(ResponseDataMap<T> value)? map,
  }) {
    return list?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResponseDataList<T> value)? list,
    TResult Function(ResponseDataMap<T> value)? map,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResponseDataListToJson<T>(this, toJsonT);
  }
}

abstract class ResponseDataList<T> implements ResponseData<T> {
  const factory ResponseDataList({required final List<T> data}) =
      _$ResponseDataList<T>;

  factory ResponseDataList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResponseDataList<T>.fromJson;

  @override
  List<T> get data;
  @JsonKey(ignore: true)
  _$$ResponseDataListCopyWith<T, _$ResponseDataList<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResponseDataMapCopyWith<T, $Res> {
  factory _$$ResponseDataMapCopyWith(_$ResponseDataMap<T> value,
          $Res Function(_$ResponseDataMap<T>) then) =
      __$$ResponseDataMapCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ResponseDataMapCopyWithImpl<T, $Res>
    extends _$ResponseDataCopyWithImpl<T, $Res, _$ResponseDataMap<T>>
    implements _$$ResponseDataMapCopyWith<T, $Res> {
  __$$ResponseDataMapCopyWithImpl(
      _$ResponseDataMap<T> _value, $Res Function(_$ResponseDataMap<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ResponseDataMap<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResponseDataMap<T> implements ResponseDataMap<T> {
  const _$ResponseDataMap({required this.data, final String? $type})
      : $type = $type ?? 'map';

  factory _$ResponseDataMap.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResponseDataMapFromJson(json, fromJsonT);

  @override
  final T data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ResponseData<$T>.map(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseDataMap<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseDataMapCopyWith<T, _$ResponseDataMap<T>> get copyWith =>
      __$$ResponseDataMapCopyWithImpl<T, _$ResponseDataMap<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<T> data) list,
    required TResult Function(T data) map,
  }) {
    return map(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<T> data)? list,
    TResult? Function(T data)? map,
  }) {
    return map?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<T> data)? list,
    TResult Function(T data)? map,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResponseDataList<T> value) list,
    required TResult Function(ResponseDataMap<T> value) map,
  }) {
    return map(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResponseDataList<T> value)? list,
    TResult? Function(ResponseDataMap<T> value)? map,
  }) {
    return map?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResponseDataList<T> value)? list,
    TResult Function(ResponseDataMap<T> value)? map,
    required TResult orElse(),
  }) {
    if (map != null) {
      return map(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResponseDataMapToJson<T>(this, toJsonT);
  }
}

abstract class ResponseDataMap<T> implements ResponseData<T> {
  const factory ResponseDataMap({required final T data}) = _$ResponseDataMap<T>;

  factory ResponseDataMap.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResponseDataMap<T>.fromJson;

  @override
  T get data;
  @JsonKey(ignore: true)
  _$$ResponseDataMapCopyWith<T, _$ResponseDataMap<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
