// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthData _$AuthDataFromJson(Map<String, dynamic> json) {
  return _AuthData.fromJson(json);
}

/// @nodoc
mixin _$AuthData {
  @HiveField(0)
  String get token => throw _privateConstructorUsedError;
  @HiveField(1)
  String get email => throw _privateConstructorUsedError;
  @HiveField(2)
  int? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthDataCopyWith<AuthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDataCopyWith<$Res> {
  factory $AuthDataCopyWith(AuthData value, $Res Function(AuthData) then) =
      _$AuthDataCopyWithImpl<$Res, AuthData>;
  @useResult
  $Res call(
      {@HiveField(0) String token,
      @HiveField(1) String email,
      @HiveField(2) int? expiresAt});
}

/// @nodoc
class _$AuthDataCopyWithImpl<$Res, $Val extends AuthData>
    implements $AuthDataCopyWith<$Res> {
  _$AuthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? email = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthDataCopyWith<$Res> implements $AuthDataCopyWith<$Res> {
  factory _$$_AuthDataCopyWith(
          _$_AuthData value, $Res Function(_$_AuthData) then) =
      __$$_AuthDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String token,
      @HiveField(1) String email,
      @HiveField(2) int? expiresAt});
}

/// @nodoc
class __$$_AuthDataCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$_AuthData>
    implements _$$_AuthDataCopyWith<$Res> {
  __$$_AuthDataCopyWithImpl(
      _$_AuthData _value, $Res Function(_$_AuthData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? email = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_$_AuthData(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: authDataTypeId, adapterName: 'AuthDataAdapter')
class _$_AuthData implements _AuthData {
  const _$_AuthData(
      {@HiveField(0) required this.token,
      @HiveField(1) required this.email,
      @HiveField(2) this.expiresAt});

  factory _$_AuthData.fromJson(Map<String, dynamic> json) =>
      _$$_AuthDataFromJson(json);

  @override
  @HiveField(0)
  final String token;
  @override
  @HiveField(1)
  final String email;
  @override
  @HiveField(2)
  final int? expiresAt;

  @override
  String toString() {
    return 'AuthData(token: $token, email: $email, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthData &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, email, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthDataCopyWith<_$_AuthData> get copyWith =>
      __$$_AuthDataCopyWithImpl<_$_AuthData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthDataToJson(
      this,
    );
  }
}

abstract class _AuthData implements AuthData {
  const factory _AuthData(
      {@HiveField(0) required final String token,
      @HiveField(1) required final String email,
      @HiveField(2) final int? expiresAt}) = _$_AuthData;

  factory _AuthData.fromJson(Map<String, dynamic> json) = _$_AuthData.fromJson;

  @override
  @HiveField(0)
  String get token;
  @override
  @HiveField(1)
  String get email;
  @override
  @HiveField(2)
  int? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$_AuthDataCopyWith<_$_AuthData> get copyWith =>
      throw _privateConstructorUsedError;
}
