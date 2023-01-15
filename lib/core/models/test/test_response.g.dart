// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TestCategory _$$_TestCategoryFromJson(Map<String, dynamic> json) =>
    _$_TestCategory(
      id: json['id'] as String,
      type: json['type'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      metaTitle: json['meta_title'] as String?,
      metaKeywords: json['meta_keywords'] as String?,
      metaDescription: json['meta_description'] as String?,
      metastatusTitle: json['metastatus_title'] as String?,
      testField: json['test_field'] as String?,
    );

Map<String, dynamic> _$$_TestCategoryToJson(_$_TestCategory instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('name', instance.name);
  writeNotNull('slug', instance.slug);
  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  writeNotNull('meta_title', instance.metaTitle);
  writeNotNull('meta_keywords', instance.metaKeywords);
  writeNotNull('meta_description', instance.metaDescription);
  writeNotNull('metastatus_title', instance.metastatusTitle);
  writeNotNull('test_field', instance.testField);
  return val;
}

_$_Test _$$_TestFromJson(Map<String, dynamic> json) => _$_Test(
      set: json['set'] == null
          ? null
          : Set.fromJson(json['set'] as Map<String, dynamic>),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TestToJson(_$_Test instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  writeNotNull('questions', instance.questions);
  return val;
}

_$_Set _$$_SetFromJson(Map<String, dynamic> json) => _$_Set(
      id: json['id'] as String,
      setName: json['set_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      totalQuestion: json['total_question'] as String?,
      examDuration: json['exam_duration'] as int?,
    );

Map<String, dynamic> _$$_SetToJson(_$_Set instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set_name', instance.setName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('total_question', instance.totalQuestion);
  writeNotNull('exam_duration', instance.examDuration);
  return val;
}

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      id: json['id'] as String,
      setId: json['set_id'] as String?,
      type: json['type'] as String?,
      question: json['question'] as String?,
      optionA: json['option_a'] as String?,
      optionB: json['option_b'] as String?,
      optionC: json['option_c'] as String?,
      optionD: json['option_d'] as String?,
      answer: json['answer'] as String?,
      paragraph: json['paragraph'] as String?,
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set_id', instance.setId);
  writeNotNull('type', instance.type);
  writeNotNull('question', instance.question);
  writeNotNull('option_a', instance.optionA);
  writeNotNull('option_b', instance.optionB);
  writeNotNull('option_c', instance.optionC);
  writeNotNull('option_d', instance.optionD);
  writeNotNull('answer', instance.answer);
  writeNotNull('paragraph', instance.paragraph);
  return val;
}

_$_TestResult _$$_TestResultFromJson(Map<String, dynamic> json) =>
    _$_TestResult(
      categoryId: json['category_id'] as String?,
      entranceSet: json['entrance_set'] as String?,
      quizKey: json['quiz_key'] as String?,
      certificateLink: json['certificate_link'] as String?,
      entranceResult: (json['entrance_result'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalQuestion: json['total_question'] as int?,
      totalScore: json['total_score'] as int?,
      totalPercent: json['total_percent'] as int?,
    );

Map<String, dynamic> _$$_TestResultToJson(_$_TestResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('category_id', instance.categoryId);
  writeNotNull('entrance_set', instance.entranceSet);
  writeNotNull('quiz_key', instance.quizKey);
  writeNotNull('certificate_link', instance.certificateLink);
  writeNotNull('entrance_result', instance.entranceResult);
  writeNotNull('total_question', instance.totalQuestion);
  writeNotNull('total_score', instance.totalScore);
  writeNotNull('total_percent', instance.totalPercent);
  return val;
}

_$_Answer _$$_AnswerFromJson(Map<String, dynamic> json) => _$_Answer(
      id: json['id'] as String,
      qno: json['qno'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      option: json['option'] as String?,
      txt: json['txt'] as String?,
    );

Map<String, dynamic> _$$_AnswerToJson(_$_Answer instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('qno', instance.qno);
  writeNotNull('question', instance.question);
  writeNotNull('answer', instance.answer);
  writeNotNull('option', instance.option);
  writeNotNull('txt', instance.txt);
  return val;
}
