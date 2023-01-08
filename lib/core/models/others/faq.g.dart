// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Faq _$$_FaqFromJson(Map<String, dynamic> json) => _$_Faq(
      id: json['id'] as String?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$$_FaqToJson(_$_Faq instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('question', instance.question);
  writeNotNull('answer', instance.answer);
  return val;
}
