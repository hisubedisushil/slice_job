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
