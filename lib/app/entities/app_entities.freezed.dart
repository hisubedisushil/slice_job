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
mixin _$AppState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(T data, bool isNavigate) authenticated,
    required TResult Function(Failure? failure, bool isNavigate)
        unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(T data, bool isNavigate)? authenticated,
    TResult? Function(Failure? failure, bool isNavigate)? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(T data, bool isNavigate)? authenticated,
    TResult Function(Failure? failure, bool isNavigate)? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted<T> value) started,
    required TResult Function(Authenticated<T> value) authenticated,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted<T> value)? started,
    TResult? Function(Authenticated<T> value)? authenticated,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted<T> value)? started,
    TResult Function(Authenticated<T> value)? authenticated,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<T, $Res> {
  factory $AppStateCopyWith(
          AppState<T> value, $Res Function(AppState<T>) then) =
      _$AppStateCopyWithImpl<T, $Res, AppState<T>>;
}

/// @nodoc
class _$AppStateCopyWithImpl<T, $Res, $Val extends AppState<T>>
    implements $AppStateCopyWith<T, $Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppStartedCopyWith<T, $Res> {
  factory _$$AppStartedCopyWith(
          _$AppStarted<T> value, $Res Function(_$AppStarted<T>) then) =
      __$$AppStartedCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AppStartedCopyWithImpl<T, $Res>
    extends _$AppStateCopyWithImpl<T, $Res, _$AppStarted<T>>
    implements _$$AppStartedCopyWith<T, $Res> {
  __$$AppStartedCopyWithImpl(
      _$AppStarted<T> _value, $Res Function(_$AppStarted<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppStarted<T> implements AppStarted<T> {
  const _$AppStarted();

  @override
  String toString() {
    return 'AppState<$T>.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStarted<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(T data, bool isNavigate) authenticated,
    required TResult Function(Failure? failure, bool isNavigate)
        unAuthenticated,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(T data, bool isNavigate)? authenticated,
    TResult? Function(Failure? failure, bool isNavigate)? unAuthenticated,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(T data, bool isNavigate)? authenticated,
    TResult Function(Failure? failure, bool isNavigate)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted<T> value) started,
    required TResult Function(Authenticated<T> value) authenticated,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted<T> value)? started,
    TResult? Function(Authenticated<T> value)? authenticated,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted<T> value)? started,
    TResult Function(Authenticated<T> value)? authenticated,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class AppStarted<T> implements AppState<T> {
  const factory AppStarted() = _$AppStarted<T>;
}

/// @nodoc
abstract class _$$AuthenticatedCopyWith<T, $Res> {
  factory _$$AuthenticatedCopyWith(
          _$Authenticated<T> value, $Res Function(_$Authenticated<T>) then) =
      __$$AuthenticatedCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data, bool isNavigate});
}

/// @nodoc
class __$$AuthenticatedCopyWithImpl<T, $Res>
    extends _$AppStateCopyWithImpl<T, $Res, _$Authenticated<T>>
    implements _$$AuthenticatedCopyWith<T, $Res> {
  __$$AuthenticatedCopyWithImpl(
      _$Authenticated<T> _value, $Res Function(_$Authenticated<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? isNavigate = null,
  }) {
    return _then(_$Authenticated<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      isNavigate: null == isNavigate
          ? _value.isNavigate
          : isNavigate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Authenticated<T> implements Authenticated<T> {
  const _$Authenticated(this.data, {this.isNavigate = false});

  @override
  final T data;
  @override
  @JsonKey()
  final bool isNavigate;

  @override
  String toString() {
    return 'AppState<$T>.authenticated(data: $data, isNavigate: $isNavigate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Authenticated<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.isNavigate, isNavigate) ||
                other.isNavigate == isNavigate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), isNavigate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedCopyWith<T, _$Authenticated<T>> get copyWith =>
      __$$AuthenticatedCopyWithImpl<T, _$Authenticated<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(T data, bool isNavigate) authenticated,
    required TResult Function(Failure? failure, bool isNavigate)
        unAuthenticated,
  }) {
    return authenticated(data, isNavigate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(T data, bool isNavigate)? authenticated,
    TResult? Function(Failure? failure, bool isNavigate)? unAuthenticated,
  }) {
    return authenticated?.call(data, isNavigate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(T data, bool isNavigate)? authenticated,
    TResult Function(Failure? failure, bool isNavigate)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(data, isNavigate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted<T> value) started,
    required TResult Function(Authenticated<T> value) authenticated,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted<T> value)? started,
    TResult? Function(Authenticated<T> value)? authenticated,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted<T> value)? started,
    TResult Function(Authenticated<T> value)? authenticated,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated<T> implements AppState<T> {
  const factory Authenticated(final T data, {final bool isNavigate}) =
      _$Authenticated<T>;

  T get data;
  bool get isNavigate;
  @JsonKey(ignore: true)
  _$$AuthenticatedCopyWith<T, _$Authenticated<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnAuthenticatedCopyWith<T, $Res> {
  factory _$$UnAuthenticatedCopyWith(_$UnAuthenticated<T> value,
          $Res Function(_$UnAuthenticated<T>) then) =
      __$$UnAuthenticatedCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Failure? failure, bool isNavigate});
}

/// @nodoc
class __$$UnAuthenticatedCopyWithImpl<T, $Res>
    extends _$AppStateCopyWithImpl<T, $Res, _$UnAuthenticated<T>>
    implements _$$UnAuthenticatedCopyWith<T, $Res> {
  __$$UnAuthenticatedCopyWithImpl(
      _$UnAuthenticated<T> _value, $Res Function(_$UnAuthenticated<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = freezed,
    Object? isNavigate = null,
  }) {
    return _then(_$UnAuthenticated<T>(
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isNavigate: null == isNavigate
          ? _value.isNavigate
          : isNavigate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UnAuthenticated<T> implements UnAuthenticated<T> {
  const _$UnAuthenticated({this.failure, this.isNavigate = false});

  @override
  final Failure? failure;
  @override
  @JsonKey()
  final bool isNavigate;

  @override
  String toString() {
    return 'AppState<$T>.unAuthenticated(failure: $failure, isNavigate: $isNavigate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnAuthenticated<T> &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isNavigate, isNavigate) ||
                other.isNavigate == isNavigate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure, isNavigate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnAuthenticatedCopyWith<T, _$UnAuthenticated<T>> get copyWith =>
      __$$UnAuthenticatedCopyWithImpl<T, _$UnAuthenticated<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(T data, bool isNavigate) authenticated,
    required TResult Function(Failure? failure, bool isNavigate)
        unAuthenticated,
  }) {
    return unAuthenticated(failure, isNavigate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(T data, bool isNavigate)? authenticated,
    TResult? Function(Failure? failure, bool isNavigate)? unAuthenticated,
  }) {
    return unAuthenticated?.call(failure, isNavigate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(T data, bool isNavigate)? authenticated,
    TResult Function(Failure? failure, bool isNavigate)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(failure, isNavigate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted<T> value) started,
    required TResult Function(Authenticated<T> value) authenticated,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted<T> value)? started,
    TResult? Function(Authenticated<T> value)? authenticated,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted<T> value)? started,
    TResult Function(Authenticated<T> value)? authenticated,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class UnAuthenticated<T> implements AppState<T> {
  const factory UnAuthenticated(
      {final Failure? failure, final bool isNavigate}) = _$UnAuthenticated<T>;

  Failure? get failure;
  bool get isNavigate;
  @JsonKey(ignore: true)
  _$$UnAuthenticatedCopyWith<T, _$UnAuthenticated<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
