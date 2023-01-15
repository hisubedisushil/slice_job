// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_response.freezed.dart';
part 'test_response.g.dart';

@freezed
class TestCategory with _$TestCategory {
  const factory TestCategory({
    required final String id,
    final String? type,
    final String? name,
    final String? slug,
    final String? description,
    final String? image,
    final String? metaTitle,
    final String? metaKeywords,
    final String? metaDescription,
    final String? metastatusTitle,
    final String? testField,
  }) = _TestCategory;

  factory TestCategory.fromJson(Map<String, dynamic> json) =>
      _$TestCategoryFromJson(json);
}

@freezed
class Test with _$Test {
  const factory Test({
    final Set? set,
    final List<Question>? questions,
  }) = _Test;

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
}

@freezed
class Set with _$Set {
  const factory Set({
    required final String id,
    final String? setName,
    final String? categoryId,
    final String? categoryName,
    final String? totalQuestion,
    final int? examDuration,
  }) = _Set;

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);
}

@freezed
class Question with _$Question {
  const factory Question({
    required final String id,
    final String? setId,
    final String? type,
    final String? question,
    final String? optionA,
    final String? optionB,
    final String? optionC,
    final String? optionD,
    final String? answer,
    final String? paragraph,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

@freezed
class TestResult with _$TestResult {
  const factory TestResult({
    final String? categoryId,
    final String? entranceSet,
    final String? quizKey,
    final String? certificateLink,
    final List<Answer>? entranceResult,
    final int? totalQuestion,
    final int? totalScore,
    final int? totalPercent,
  }) = _TestResult;

  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);
}

@freezed
class Answer with _$Answer {
  const factory Answer({
    required final String id,
    final int? qno,
    final String? question,
    final String? answer,
    final String? option,
    final String? txt,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
