// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthData data) authenticated,
    required TResult Function(Failure? failure) unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthData data)? authenticated,
    TResult? Function(Failure? failure)? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthData data)? authenticated,
    TResult Function(Failure? failure)? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) initial,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? initial,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? initial,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppStartedCopyWith<$Res> {
  factory _$$AppStartedCopyWith(
          _$AppStarted value, $Res Function(_$AppStarted) then) =
      __$$AppStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppStartedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStarted>
    implements _$$AppStartedCopyWith<$Res> {
  __$$AppStartedCopyWithImpl(
      _$AppStarted _value, $Res Function(_$AppStarted) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppStarted implements AppStarted {
  const _$AppStarted();

  @override
  String toString() {
    return 'AppState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthData data) authenticated,
    required TResult Function(Failure? failure) unAuthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthData data)? authenticated,
    TResult? Function(Failure? failure)? unAuthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthData data)? authenticated,
    TResult Function(Failure? failure)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) initial,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? initial,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? initial,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AppStarted implements AppState {
  const factory AppStarted() = _$AppStarted;
}

/// @nodoc
abstract class _$$AuthenticatedCopyWith<$Res> {
  factory _$$AuthenticatedCopyWith(
          _$Authenticated value, $Res Function(_$Authenticated) then) =
      __$$AuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthData data});

  $AuthDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$AuthenticatedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$Authenticated>
    implements _$$AuthenticatedCopyWith<$Res> {
  __$$AuthenticatedCopyWithImpl(
      _$Authenticated _value, $Res Function(_$Authenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$Authenticated(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthDataCopyWith<$Res> get data {
    return $AuthDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$Authenticated implements Authenticated {
  const _$Authenticated(this.data);

  @override
  final AuthData data;

  @override
  String toString() {
    return 'AppState.authenticated(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Authenticated &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedCopyWith<_$Authenticated> get copyWith =>
      __$$AuthenticatedCopyWithImpl<_$Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthData data) authenticated,
    required TResult Function(Failure? failure) unAuthenticated,
  }) {
    return authenticated(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthData data)? authenticated,
    TResult? Function(Failure? failure)? unAuthenticated,
  }) {
    return authenticated?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthData data)? authenticated,
    TResult Function(Failure? failure)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) initial,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? initial,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? initial,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AppState {
  const factory Authenticated(final AuthData data) = _$Authenticated;

  AuthData get data;
  @JsonKey(ignore: true)
  _$$AuthenticatedCopyWith<_$Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnAuthenticatedCopyWith<$Res> {
  factory _$$UnAuthenticatedCopyWith(
          _$UnAuthenticated value, $Res Function(_$UnAuthenticated) then) =
      __$$UnAuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure? failure});
}

/// @nodoc
class __$$UnAuthenticatedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$UnAuthenticated>
    implements _$$UnAuthenticatedCopyWith<$Res> {
  __$$UnAuthenticatedCopyWithImpl(
      _$UnAuthenticated _value, $Res Function(_$UnAuthenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_$UnAuthenticated(
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$UnAuthenticated implements UnAuthenticated {
  const _$UnAuthenticated({this.failure});

  @override
  final Failure? failure;

  @override
  String toString() {
    return 'AppState.unAuthenticated(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnAuthenticated &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnAuthenticatedCopyWith<_$UnAuthenticated> get copyWith =>
      __$$UnAuthenticatedCopyWithImpl<_$UnAuthenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthData data) authenticated,
    required TResult Function(Failure? failure) unAuthenticated,
  }) {
    return unAuthenticated(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthData data)? authenticated,
    TResult? Function(Failure? failure)? unAuthenticated,
  }) {
    return unAuthenticated?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthData data)? authenticated,
    TResult Function(Failure? failure)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) initial,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? initial,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? initial,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class UnAuthenticated implements AppState {
  const factory UnAuthenticated({final Failure? failure}) = _$UnAuthenticated;

  Failure? get failure;
  @JsonKey(ignore: true)
  _$$UnAuthenticatedCopyWith<_$UnAuthenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthState {
  bool get isInitial => throw _privateConstructorUsedError;
  bool get isAuthenticating => throw _privateConstructorUsedError;
  bool get isAuthenticated => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  AuthData? get authData => throw _privateConstructorUsedError;
  Failure? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {bool isInitial,
      bool isAuthenticating,
      bool isAuthenticated,
      User? user,
      AuthData? authData,
      Failure? error});

  $UserCopyWith<$Res>? get user;
  $AuthDataCopyWith<$Res>? get authData;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitial = null,
    Object? isAuthenticating = null,
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? authData = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isInitial: null == isInitial
          ? _value.isInitial
          : isInitial // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticating: null == isAuthenticating
          ? _value.isAuthenticating
          : isAuthenticating // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      authData: freezed == authData
          ? _value.authData
          : authData // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthDataCopyWith<$Res>? get authData {
    if (_value.authData == null) {
      return null;
    }

    return $AuthDataCopyWith<$Res>(_value.authData!, (value) {
      return _then(_value.copyWith(authData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateCopyWith(
          _$_AuthState value, $Res Function(_$_AuthState) then) =
      __$$_AuthStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isInitial,
      bool isAuthenticating,
      bool isAuthenticated,
      User? user,
      AuthData? authData,
      Failure? error});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $AuthDataCopyWith<$Res>? get authData;
}

/// @nodoc
class __$$_AuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthState>
    implements _$$_AuthStateCopyWith<$Res> {
  __$$_AuthStateCopyWithImpl(
      _$_AuthState _value, $Res Function(_$_AuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitial = null,
    Object? isAuthenticating = null,
    Object? isAuthenticated = null,
    Object? user = freezed,
    Object? authData = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_AuthState(
      isInitial: null == isInitial
          ? _value.isInitial
          : isInitial // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticating: null == isAuthenticating
          ? _value.isAuthenticating
          : isAuthenticating // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      authData: freezed == authData
          ? _value.authData
          : authData // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$_AuthState implements _AuthState {
  const _$_AuthState(
      {required this.isInitial,
      required this.isAuthenticating,
      required this.isAuthenticated,
      this.user,
      this.authData,
      this.error});

  @override
  final bool isInitial;
  @override
  final bool isAuthenticating;
  @override
  final bool isAuthenticated;
  @override
  final User? user;
  @override
  final AuthData? authData;
  @override
  final Failure? error;

  @override
  String toString() {
    return 'AuthState(isInitial: $isInitial, isAuthenticating: $isAuthenticating, isAuthenticated: $isAuthenticated, user: $user, authData: $authData, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthState &&
            (identical(other.isInitial, isInitial) ||
                other.isInitial == isInitial) &&
            (identical(other.isAuthenticating, isAuthenticating) ||
                other.isAuthenticating == isAuthenticating) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.authData, authData) ||
                other.authData == authData) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isInitial, isAuthenticating,
      isAuthenticated, user, authData, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      __$$_AuthStateCopyWithImpl<_$_AuthState>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {required final bool isInitial,
      required final bool isAuthenticating,
      required final bool isAuthenticated,
      final User? user,
      final AuthData? authData,
      final Failure? error}) = _$_AuthState;

  @override
  bool get isInitial;
  @override
  bool get isAuthenticating;
  @override
  bool get isAuthenticated;
  @override
  User? get user;
  @override
  AuthData? get authData;
  @override
  Failure? get error;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
