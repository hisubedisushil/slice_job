// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Faq _$FaqFromJson(Map<String, dynamic> json) {
  return _Faq.fromJson(json);
}

/// @nodoc
mixin _$Faq {
  String? get id => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqCopyWith<Faq> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqCopyWith<$Res> {
  factory $FaqCopyWith(Faq value, $Res Function(Faq) then) =
      _$FaqCopyWithImpl<$Res, Faq>;
  @useResult
  $Res call({String? id, String? question, String? answer});
}

/// @nodoc
class _$FaqCopyWithImpl<$Res, $Val extends Faq> implements $FaqCopyWith<$Res> {
  _$FaqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FaqCopyWith<$Res> implements $FaqCopyWith<$Res> {
  factory _$$_FaqCopyWith(_$_Faq value, $Res Function(_$_Faq) then) =
      __$$_FaqCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? question, String? answer});
}

/// @nodoc
class __$$_FaqCopyWithImpl<$Res> extends _$FaqCopyWithImpl<$Res, _$_Faq>
    implements _$$_FaqCopyWith<$Res> {
  __$$_FaqCopyWithImpl(_$_Faq _value, $Res Function(_$_Faq) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_$_Faq(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Faq implements _Faq {
  const _$_Faq({this.id, this.question, this.answer});

  factory _$_Faq.fromJson(Map<String, dynamic> json) => _$$_FaqFromJson(json);

  @override
  final String? id;
  @override
  final String? question;
  @override
  final String? answer;

  @override
  String toString() {
    return 'Faq(id: $id, question: $question, answer: $answer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Faq &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, question, answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FaqCopyWith<_$_Faq> get copyWith =>
      __$$_FaqCopyWithImpl<_$_Faq>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FaqToJson(
      this,
    );
  }
}

abstract class _Faq implements Faq {
  const factory _Faq(
      {final String? id,
      final String? question,
      final String? answer}) = _$_Faq;

  factory _Faq.fromJson(Map<String, dynamic> json) = _$_Faq.fromJson;

  @override
  String? get id;
  @override
  String? get question;
  @override
  String? get answer;
  @override
  @JsonKey(ignore: true)
  _$$_FaqCopyWith<_$_Faq> get copyWith => throw _privateConstructorUsedError;
}
