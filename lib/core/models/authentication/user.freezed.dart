// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @HiveField(0)
  String? get firstName => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get lastName => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get email => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get regDate => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get regIp => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get emailConfirm => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get userType => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get typeApproved => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@HiveField(0) String? firstName,
      @HiveField(1) String? lastName,
      @HiveField(2) String? email,
      @HiveField(3) String? regDate,
      @HiveField(4) String? regIp,
      @HiveField(5) String? emailConfirm,
      @HiveField(6) String? userType,
      @HiveField(7) String? typeApproved});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? regDate = freezed,
    Object? regIp = freezed,
    Object? emailConfirm = freezed,
    Object? userType = freezed,
    Object? typeApproved = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      regDate: freezed == regDate
          ? _value.regDate
          : regDate // ignore: cast_nullable_to_non_nullable
              as String?,
      regIp: freezed == regIp
          ? _value.regIp
          : regIp // ignore: cast_nullable_to_non_nullable
              as String?,
      emailConfirm: freezed == emailConfirm
          ? _value.emailConfirm
          : emailConfirm // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      typeApproved: freezed == typeApproved
          ? _value.typeApproved
          : typeApproved // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? firstName,
      @HiveField(1) String? lastName,
      @HiveField(2) String? email,
      @HiveField(3) String? regDate,
      @HiveField(4) String? regIp,
      @HiveField(5) String? emailConfirm,
      @HiveField(6) String? userType,
      @HiveField(7) String? typeApproved});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? regDate = freezed,
    Object? regIp = freezed,
    Object? emailConfirm = freezed,
    Object? userType = freezed,
    Object? typeApproved = freezed,
  }) {
    return _then(_$_User(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      regDate: freezed == regDate
          ? _value.regDate
          : regDate // ignore: cast_nullable_to_non_nullable
              as String?,
      regIp: freezed == regIp
          ? _value.regIp
          : regIp // ignore: cast_nullable_to_non_nullable
              as String?,
      emailConfirm: freezed == emailConfirm
          ? _value.emailConfirm
          : emailConfirm // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      typeApproved: freezed == typeApproved
          ? _value.typeApproved
          : typeApproved // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: userTypeId, adapterName: 'UserAdapter')
class _$_User implements _User {
  const _$_User(
      {@HiveField(0) this.firstName,
      @HiveField(1) this.lastName,
      @HiveField(2) this.email,
      @HiveField(3) this.regDate,
      @HiveField(4) this.regIp,
      @HiveField(5) this.emailConfirm,
      @HiveField(6) this.userType,
      @HiveField(7) this.typeApproved});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @HiveField(0)
  final String? firstName;
  @override
  @HiveField(1)
  final String? lastName;
  @override
  @HiveField(2)
  final String? email;
  @override
  @HiveField(3)
  final String? regDate;
  @override
  @HiveField(4)
  final String? regIp;
  @override
  @HiveField(5)
  final String? emailConfirm;
  @override
  @HiveField(6)
  final String? userType;
  @override
  @HiveField(7)
  final String? typeApproved;

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, regDate: $regDate, regIp: $regIp, emailConfirm: $emailConfirm, userType: $userType, typeApproved: $typeApproved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.regDate, regDate) || other.regDate == regDate) &&
            (identical(other.regIp, regIp) || other.regIp == regIp) &&
            (identical(other.emailConfirm, emailConfirm) ||
                other.emailConfirm == emailConfirm) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.typeApproved, typeApproved) ||
                other.typeApproved == typeApproved));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, email,
      regDate, regIp, emailConfirm, userType, typeApproved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@HiveField(0) final String? firstName,
      @HiveField(1) final String? lastName,
      @HiveField(2) final String? email,
      @HiveField(3) final String? regDate,
      @HiveField(4) final String? regIp,
      @HiveField(5) final String? emailConfirm,
      @HiveField(6) final String? userType,
      @HiveField(7) final String? typeApproved}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @HiveField(0)
  String? get firstName;
  @override
  @HiveField(1)
  String? get lastName;
  @override
  @HiveField(2)
  String? get email;
  @override
  @HiveField(3)
  String? get regDate;
  @override
  @HiveField(4)
  String? get regIp;
  @override
  @HiveField(5)
  String? get emailConfirm;
  @override
  @HiveField(6)
  String? get userType;
  @override
  @HiveField(7)
  String? get typeApproved;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
